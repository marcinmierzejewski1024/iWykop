//
//  ApiV2Service.swift
//  iWykop
//
//  Created by Marcin Mierzejewski on 18/02/2022.
//

import Foundation
import Resolver

class ApiV2Service : Resolving
{
    
    static let baseUrl = "https://a2.wykop.pl/"
    
    var compacted = false;
    
    lazy var bodyFormatter : BodyFormater = resolver.resolve();
    lazy var apiClient: ApiClient = resolver.resolve()
    
    func urlParams() -> [String: String]?
    {
        do {
            var additionalParams = [String:String]();
            additionalParams["appkey"] = try ApiV2Service.getApiCreditentialsValue("ApiKey")
            additionalParams["data"] = self.dataExpected();
            //        additionalParams["userKey"] = self.dataExpected();TODO:jak bedzie logowanie
            
            return additionalParams;
        } catch {
            print(error);
        }
        
        return nil;
    }
    
    
    func headers() -> ApiRequestHeaders?
    {
        var additionalHeaders = [String:String]();
        do {
            
            let secret = try ApiV2Service.getApiCreditentialsValue("ApiSecret");
            
            additionalHeaders["apisign"] = MD5(string: (secret + self.getUrl()))
            
            
            return additionalHeaders;
        } catch {
            print(error);
        }
        
        return nil;
    }
    
    
    func getPath() -> String {
        return "";
    }
    
    
    func getUrl() -> String {
        return ApiV2Service.baseUrl + getPath() + ApiV2Service.urlParamsToQuery(self.urlParams());
    }
    
    
    func dataExpected() -> String {
        return self.compacted ? "compacted": "full";
    }
    
    
    func mapDataToEntities<T : Codable>(_ t: T.Type, data:Data) -> T?
    {
        
        let decoder = JSONDecoder()

        do {
            let respo = try decoder.decode(ApiV2Response<T>.self, from: data)
            if let err = respo.error {
                throw err.messageEn;
            }

            return respo.data!;
            
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        
        return nil;

    }
    
    
    //["key":"value","key2":"value2"] -> key/value/key2/value2
    static func urlParamsToQuery(_ parameters: [String: Any]?) -> String {
        
        
        var components: [(String, String)] = []

        if let parameters = parameters {
            for key in parameters.keys.sorted(by: <) {
                let value = parameters[key]!
                components.append((key,"\(value)"));
            }
        }
        return components.map { "\($0)/\($1)" }.joined(separator: "/")
    }
    
    
    
    static func getApiCreditentialsValue(_ name: String) throws -> String  {
        if let path = Bundle.main.path(forResource: "apiCreditentials", ofType: "plist") {
            if let entries = NSDictionary(contentsOfFile: path){
                return entries[name] as! String;
            }
        }
        
        throw "Check apiCreditentials.plist!";
    }
    
}
