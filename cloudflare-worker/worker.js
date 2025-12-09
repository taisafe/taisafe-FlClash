// TaiSafe API Proxy Worker
// 部署域名: cn.bbcareadvi.com.tw
// 功能: 作為中間代理，隱藏真實後端域名

export default {
    async fetch(request, env) {
        const url = new URL(request.url);
        const path = url.pathname;

        // 根據路徑決定轉發目標
        let targetHost;

        if (path.startsWith('/api/')) {
            // API 請求 → V2Board 後端
            targetHost = 'www.taisafe.cc';
        } else if (path.startsWith('/s/')) {
            // 訂閱請求 → 訂閱服務器
            targetHost = 'qq.xcsqq.top';
        } else {
            // 默認轉發到 API 後端
            targetHost = 'www.taisafe.cc';
        }

        // 構建新請求 URL
        const newUrl = new URL(request.url);
        newUrl.hostname = targetHost;

        // 複製原始請求的 headers
        const newHeaders = new Headers(request.headers);
        newHeaders.set('Host', targetHost);
        // 移除可能暴露代理的 headers
        newHeaders.delete('cf-connecting-ip');
        newHeaders.delete('cf-ray');
        newHeaders.delete('cf-visitor');

        // 創建新請求
        const newRequest = new Request(newUrl, {
            method: request.method,
            headers: newHeaders,
            body: request.body,
            redirect: 'follow',
        });

        // 處理 OPTIONS 預檢請求 (CORS)
        if (request.method === 'OPTIONS') {
            return new Response(null, {
                status: 204,
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Requested-With',
                    'Access-Control-Max-Age': '86400',
                },
            });
        }

        try {
            // 轉發請求到目標服務器
            const response = await fetch(newRequest);

            // 創建新的響應，添加 CORS headers
            const newResponse = new Response(response.body, {
                status: response.status,
                statusText: response.statusText,
                headers: response.headers,
            });

            // 添加 CORS headers
            newResponse.headers.set('Access-Control-Allow-Origin', '*');

            return newResponse;
        } catch (error) {
            // 錯誤處理
            return new Response(JSON.stringify({ error: 'Proxy error', message: error.message }), {
                status: 502,
                headers: {
                    'Content-Type': 'application/json',
                    'Access-Control-Allow-Origin': '*',
                },
            });
        }
    }
}
