package bit.team.eepp.API;

public class GoogleOAuthInfo {
	    
	    private String clientId;
	    private String clientSecret;
	    
	    
	    public GoogleOAuthInfo(String clientId, String clientSecret) {
	        this.clientId = clientId;
	        this.clientSecret = clientSecret;
	    }
	 
	 
	    public String getClientId() {
	        return clientId;
	    }
	 
	 
	    public String getClientSecret() {
	        return clientSecret;
	    }

}
