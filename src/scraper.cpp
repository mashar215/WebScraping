#include <iostream>
#include <curl/curl.h>
#include <libxml/HTMLparser.h>
#include <libxml/xpath.h>

/*
    1:Download the target page with libcurl.
    2:Parse the retrieved HTML document and scrape data from it with libxml2.
    3:Export the collected data to a file.

*/

//プロトタイプ宣言

std::string get_request(std::string url)

int main(){
    
    
    curl_global_init(CURL_GLOBAL_ALL);

    std::string html_document = get_request("https://scrapeme.live/shop/");
    std::cout << html_document;

    //マークアップ言語をとってきた後の処理

    //解放処理

    curl_global_cleanup();

    return 0;
    
}

std::string get_request(std::string url){

    //CURLポインタの初期化
    //必ず最後に解放処理を行うこと。

    CURL *curl = curl_easy_init();

    std::string result;


    if(curl){

        //リクエストを出す。
        //このあたりのメモリのアクセス違反が生じるのはたぶん、バッファーのサイズが足らないから。
        curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
        curl_easy_setopt(curl,CURLOPT_WRITEFUNCTION,[](void *contents,size_t size,size_t nmemb,std::string *response){
            ((std::string*) response) -> append((char*) contents, size * nmemb);
        });

        curl_easy_setopt(curl,CURLOPT_WRITEDATA, &result);
        curl_easy_perform(curl);
        
        //解放処理
        curl_easy_cleanup(curl);
    }

    return result;

}


