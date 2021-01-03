package bean;

public class User extends Passage {
    private int userId;
    private String password;
    private String nickName;
    private int administrator;
    public User(){}
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getNickName() {
        return nickName;
    }
    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
    public int getAdministrator() {
        return administrator;
    }
    public void setAdministrator(int administrator) {
        this.administrator = administrator;
    }
    public static Integer StringIdToIntegerId(String userIdString){
        if(userIdString==null||userIdString.equals(""))
            return null;
        Integer userId=null;
        try {
            userId=Integer.parseInt(userIdString);
        }catch (Exception e){
            return null;
        }
        return userId;
    }
}
