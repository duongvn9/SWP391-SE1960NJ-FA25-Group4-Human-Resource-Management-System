package group4.hrms.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Utility class để xử lý Google OAuth2
 */
public final class GoogleOAuthUtil {

    private static final ObjectMapper objectMapper = new ObjectMapper();
    private static final int TIMEOUT = 30000; // 30 seconds

    // Private constructor để ngăn instantiation
    private GoogleOAuthUtil() {
        throw new UnsupportedOperationException("Utility class không thể được khởi tạo");
    }

    /**
     * Tạo URL để redirect user đến Google OAuth
     * 
     * @param clientId    Google Client ID
     * @param redirectUri Redirect URI
     * @param scopes      OAuth scopes
     * @param state       State parameter để bảo mật
     * @return Google OAuth URL
     */
    public static String buildAuthUrl(String clientId, String redirectUri, String scopes, String state) {
        try {
            StringBuilder urlBuilder = new StringBuilder("https://accounts.google.com/o/oauth2/auth");
            urlBuilder.append("?response_type=code");
            urlBuilder.append("&client_id=").append(URLEncoder.encode(clientId, StandardCharsets.UTF_8));
            urlBuilder.append("&redirect_uri=").append(URLEncoder.encode(redirectUri, StandardCharsets.UTF_8));
            urlBuilder.append("&scope=").append(URLEncoder.encode(scopes, StandardCharsets.UTF_8));
            urlBuilder.append("&access_type=offline");
            urlBuilder.append("&prompt=consent");

            if (state != null && !state.trim().isEmpty()) {
                urlBuilder.append("&state=").append(URLEncoder.encode(state, StandardCharsets.UTF_8));
            }

            return urlBuilder.toString();
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tạo Google OAuth URL", e);
        }
    }

    /**
     * Exchange authorization code để lấy access token
     * 
     * @param code         Authorization code từ Google
     * @param clientId     Google Client ID
     * @param clientSecret Google Client Secret
     * @param redirectUri  Redirect URI
     * @return Access token response
     * @throws IOException nếu có lỗi network
     */
    public static Map<String, Object> exchangeCodeForToken(String code, String clientId,
            String clientSecret, String redirectUri) throws IOException {

        Map<String, String> params = new HashMap<>();
        params.put("code", code);
        params.put("client_id", clientId);
        params.put("client_secret", clientSecret);
        params.put("redirect_uri", redirectUri);
        params.put("grant_type", "authorization_code");

        String response = sendPostRequest("https://oauth2.googleapis.com/token", params);
        return parseJsonResponse(response);
    }

    /**
     * Lấy thông tin user từ Google API
     * 
     * @param accessToken Access token
     * @return User info
     * @throws IOException nếu có lỗi network
     */
    public static Map<String, Object> getUserInfo(String accessToken) throws IOException {
        String response = sendGetRequest("https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + accessToken);
        return parseJsonResponse(response);
    }

    /**
     * Send POST request
     */
    private static String sendPostRequest(String urlString, Map<String, String> params) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        try {
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            connection.setDoOutput(true);
            connection.setConnectTimeout(TIMEOUT);
            connection.setReadTimeout(TIMEOUT);

            // Build parameters
            StringJoiner sj = new StringJoiner("&");
            for (Map.Entry<String, String> entry : params.entrySet()) {
                sj.add(URLEncoder.encode(entry.getKey(), StandardCharsets.UTF_8) + "=" +
                        URLEncoder.encode(entry.getValue(), StandardCharsets.UTF_8));
            }

            // Send request
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = sj.toString().getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Read response
            return readResponse(connection);

        } finally {
            connection.disconnect();
        }
    }

    /**
     * Send GET request
     */
    private static String sendGetRequest(String urlString) throws IOException {
        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        try {
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(TIMEOUT);
            connection.setReadTimeout(TIMEOUT);

            return readResponse(connection);

        } finally {
            connection.disconnect();
        }
    }

    /**
     * Read response from connection
     */
    private static String readResponse(HttpURLConnection connection) throws IOException {
        int responseCode = connection.getResponseCode();

        InputStream inputStream;
        if (responseCode >= 200 && responseCode < 300) {
            inputStream = connection.getInputStream();
        } else {
            inputStream = connection.getErrorStream();
        }

        if (inputStream == null) {
            throw new IOException("Không thể đọc response từ server");
        }

        try (InputStream is = inputStream) {
            byte[] bytes = is.readAllBytes();
            String response = new String(bytes, StandardCharsets.UTF_8);

            if (responseCode >= 400) {
                throw new IOException("HTTP Error " + responseCode + ": " + response);
            }

            return response;
        }
    }

    /**
     * Parse JSON response
     */
    private static Map<String, Object> parseJsonResponse(String jsonString) throws IOException {
        try {
            JsonNode jsonNode = objectMapper.readTree(jsonString);
            Map<String, Object> result = new HashMap<>();

            jsonNode.fields().forEachRemaining(entry -> {
                String key = entry.getKey();
                JsonNode value = entry.getValue();

                if (value.isTextual()) {
                    result.put(key, value.asText());
                } else if (value.isNumber()) {
                    result.put(key, value.asLong());
                } else if (value.isBoolean()) {
                    result.put(key, value.asBoolean());
                } else {
                    result.put(key, value.toString());
                }
            });

            return result;
        } catch (Exception e) {
            throw new IOException("Lỗi khi parse JSON response", e);
        }
    }
}