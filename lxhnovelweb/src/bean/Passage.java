package bean;

public class Passage extends Book {
    private int bookId;
    private int passageNumber;
    private String passageName;
    private String passagePosition;
    public Passage(){}
    public int getBookId() {
        return bookId;
    }
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    public int getPassageNumber() {
        return passageNumber;
    }
    public void setPassageNumber(int passageNumber) {
        this.passageNumber = passageNumber;
    }
    public String getPassageName() {
        return passageName;
    }
    public void setPassageName(String passageName) {
        this.passageName = passageName;
    }
    public String getPassagePosition() {
        return passagePosition;
    }
    public void setPassagePosition(String passagePosition) {
        this.passagePosition = passagePosition;
    }
    public static Integer passageNumberStringToPassageNumber(String passageNameString){
        if(passageNameString==null||passageNameString.equals(""))
            return null;
        Integer newPassageNumber=null;
        try {
            newPassageNumber=Integer.parseInt(passageNameString);
        }catch (Exception e){
            return null;
        }
        return newPassageNumber;
    }
}
