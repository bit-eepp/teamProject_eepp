package bit.team.eepp.API;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class NaverAPI extends DefaultApi20{

    protected NaverAPI(){
    }

    private static class InstanceHolder{
        private static final NaverAPI INSTANCE = new NaverAPI();
    }


    public static NaverAPI instance(){
        return InstanceHolder.INSTANCE;
    }

    @Override
    public String getAccessTokenEndpoint() {
        return "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
    }                   

    @Override
    protected String getAuthorizationBaseUrl() {
        return "https://nid.naver.com/oauth2.0/authorize";
    }   
}
