package bean;

public class Book {
    private int bookId;
    private String bookName;
    private String cover;
    private String folder;
    private String introduction;
    private int   classification;
    private String author;
    private int readTimes=0;
    public Book(){}
    public int getBookId() {
        return bookId;
    }
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    public String getBookName() {
        return bookName;
    }
    public void setBookName(String bookName) {
        this.bookName = bookName;
    }
    public String getCover() {
        return cover;
    }
    public void setCover(String cover) {
        this.cover = cover;
    }
    public String getFolder() {
        return folder;
    }
    public void setFolder(String folder) {
        this.folder = folder;
    }
    public String getIntroduction() {
        return introduction;
    }
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }
    public int   getClassification() {
        return classification;
    }
    public void setClassification(int  classification) {
        this.classification = classification;
    }
    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
    public int getReadTimes() {
        return readTimes;
    }
    public void setReadTimes(int readTimes) {
        this.readTimes = readTimes;
    }

    public static Integer BookStringToBookId(String bookIdString){
        if(bookIdString==null||bookIdString.equals(""))
            return null;
        Integer bookId=null;
        try {
            bookId=Integer.parseInt(bookIdString);
        }catch (Exception e){
            return null;
        }
        return bookId;
    }
    public static Integer classificationStringToClassificationInteger(String classificationString){
        if(classificationString==null||classificationString.equals(""))
            return null;
        Integer classification=null;
        try {
            classification=Integer.parseInt(classificationString);
        }catch (Exception e){
            classification=null;
        }
        return classification;
    }
    @Override
    public String toString() {
        return "Book{" +
                "bookId=" + bookId +
                ", bookName='" + bookName + '\'' +
                ", cover='" + cover + '\'' +
                ", folder='" + folder + '\'' +
                ", introduction='" + introduction + '\'' +
                ", classification=" + classification +
                ", author='" + author + '\'' +
                '}';
    }
}
