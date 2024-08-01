vcl 4.0;

backend default {
        .host = "frontend-proxy";
        .port = "8080";
}

sub vcl_recv {
        set req.backend_hint= default;

        if (req.method == "PURGE") {
            return (purge);
        }

        if (req.method != "GET" && req.method != "HEAD" &&
            req.method != "PUT" && req.method != "POST" &&
            req.method != "TRACE" && req.method != "OPTIONS" &&
            req.method != "DELETE") {
                return (pipe);
        }

        if (req.method != "GET" && req.method != "HEAD") {
            return (pass);
        }

        if (req.http.If-None-Match) {
                return (pass);
        }

        if (req.http.X-Debug-Server) {
                return (pass);
        }

        if (req.http.Cache-Control ~ "no-cache") {
                ban(req.url);
        }

        if (req.http.Accept-Encoding) {
          if (req.http.User-Agent ~ "MSIE 6") {
            unset req.http.Accept-Encoding;
          } elsif (req.http.Accept-Encoding ~ "gzip") {
            set req.http.Accept-Encoding = "gzip";
          } elsif (req.http.Accept-Encoding ~ "deflate") {
            set req.http.Accept-Encoding = "deflate";
          } else {
            unset req.http.Accept-Encoding;
          }
        }

        if (req.url ~ "action=amp$") {
                unset req.http.Cookie;
                unset req.http.x-wap;
                return (hash);
        }

        if (req.http.Authorization || req.http.Cookie ~ "([sS]ession|Token)=") {
            return (pass);
        }

        if (req.http.Cookie ~ "droidwikiwikicookiewarning_dismissed=true") {
                set req.http.Cookie = "droidwikiwikicookiewarning_dismissed=true";
        } else {
                unset req.http.Cookie;
        }

        unset req.http.x-wap;
        if (req.http.User-Agent ~ "(?i)^(lg-|sie-|nec-|lge-|sgh-|pg-)|(mobi|240x240|240x320|320x320|alcatel|android|audiovox|bada|benq|blackberry|cdm-|compal-|docomo|ericsson|hiptop|htc[-_]|huawei|ipod|kddi-|kindle|meego|midp|mitsu|mmp\/|mot-|motor|ngm_|nintendo|opera.m|palm|panasonic|philips|phone|playstation|portalmmm|sagem-|samsung|sanyo|sec-|sendo|sharp|softbank|symbian|teleca|up.browser|webos)" && req.url !~ "(\?|&)(action=amp)") {
                set req.http.x-wap = "no";
        }

        if (req.http.Cookie ~ "mf_useformat=") {
                set req.http.x-wap = "no";
        }

        return (hash);
}

sub vcl_hash {
        hash_data(req.http.x-wap);
}

sub vcl_pipe {
        set req.http.connection = "close";
}

sub vcl_purge {
        if (req.url !~ "(\?|&)(action=amp)") {
                set req.http.X-Original = req.url;
                if (req.url ~ "&") {
                        set req.url = req.url + "&action=amp";
                } else {
                        set req.url = req.url + "?action=amp";
                }
                return (restart);
        }

        if (req.http.X-Original) {
                set req.url = req.http.X-Original;
        }

        if (!req.http.x-wap) {
                set req.http.x-wap = "no";
                return (restart);
        }
}

sub vcl_hit {
        if (req.method == "PURGE") {
            ban(req.url);
            return (synth(200, "Purged"));
        }

        if (!obj.ttl > 0s) {
            return (pass);
        }
}

sub vcl_miss {
        if (req.method == "PURGE")  {
            return (synth(200, "Not in cache"));
        }
}

sub vcl_deliver {
        if (obj.hits > 0) {
                set resp.http.X-Cache = "HIT";
        } else {
                set resp.http.X-Cache = "MISS";
        }
}

sub vcl_backend_response {
        set beresp.grace = 120s;
        set beresp.http.x-origin = beresp.backend.name;

        if (beresp.ttl < 48h) {
          set beresp.ttl = 48h;
        }

        if (!beresp.ttl > 0s) {
          set beresp.uncacheable = true;
          return (deliver);
        }

        if (beresp.http.Set-Cookie) {
          set beresp.uncacheable = true;
          return (deliver);
        }

        if (beresp.http.Authorization && !beresp.http.Cache-Control ~ "public") {
          set beresp.uncacheable = true;
          return (deliver);
        }

        if (beresp.status == 404 || beresp.status == 500) {
            set beresp.ttl = 120s;
            set beresp.uncacheable = true;
            return (deliver);
        }
}
