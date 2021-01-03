package dao;

import bean.Passage;
import utils.DBUtils;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class PassageDAO {
    public ArrayList<Passage> getAllPassageById(int id) throws SQLException, IOException, ClassNotFoundException {
        String sql = "select * from passage where bookId=" + id + " order by passageNumber";
        DBUtils dbUtils = new DBUtils();
        ResultSet resultSet = dbUtils.search(sql);
        ArrayList<Passage> passageArrayList = new ArrayList<>();
        Passage passage = null;
        while (resultSet.next()) {
            passage = new Passage();
            passage.setBookId(resultSet.getInt("bookId"));
            passage.setPassageNumber(resultSet.getInt("passageNumber"));
            passage.setPassageName(resultSet.getString("passageName"));
            passage.setPassagePosition(resultSet.getString("passagePosition"));
            passageArrayList.add(passage);
        }
        return passageArrayList;
    }

    public Passage getOnePassageByBookIdPassageId(int bookId, int passageNumber) throws SQLException, IOException, ClassNotFoundException {
        System.out.println("是否进入了获取passageDAO");
        String sql = "select * from passage where bookId=" + bookId + " and passageNumber=" + passageNumber;
        System.out.println(sql);
        DBUtils dbUtils = new DBUtils();
        ResultSet resultSet = dbUtils.search(sql);
        System.out.println("查询是否成功,输出result:" + resultSet);
        Passage passage = null;
        if (resultSet.next()) {
            passage = new Passage();
            passage.setBookId(resultSet.getInt("bookId"));
            passage.setPassageNumber(resultSet.getInt("passageNumber"));
            passage.setPassageName(resultSet.getString("passageName"));
            passage.setPassagePosition(resultSet.getString("passagePosition"));
        }
        dbUtils.close();
        return passage;
    }

    public Passage getPassageByNTH(int bookId, int nth) throws SQLException, IOException, ClassNotFoundException {
        String sql = "select * from passage where bookId=" + bookId + " order by passageNumber limit " + (nth - 1) + ",1";
        DBUtils dbUtils = new DBUtils();
        ResultSet resultSet = dbUtils.search(sql);
        Passage passage = null;
        if (resultSet.next()) {
            passage = new Passage();
            passage.setBookId(resultSet.getInt("bookId"));
            passage.setPassageNumber(resultSet.getInt("passageNumber"));
            passage.setPassageName(resultSet.getString("passageName"));
            passage.setPassagePosition(resultSet.getString("passagePosition"));
        }
        dbUtils.close();
        return passage;
    }

    public int inertNewPassage(int bookId, String passageName) throws SQLException, IOException, ClassNotFoundException {
        String sql = "insert into passage(bookId,passageName) values(" + bookId + ",'" + passageName + "')";
        DBUtils dbUtils = new DBUtils();
        Statement statement = dbUtils.getStatement();
        statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
        int newPassageNumber = -1;
        ResultSet resultSet = statement.getGeneratedKeys();
        if (resultSet.next())
            newPassageNumber = resultSet.getInt(1);
        resultSet.close();
        dbUtils.close();
        return newPassageNumber;
    }
    public void updatePassagePosition(int bookId,int passageNumber,String passagePosition) throws SQLException, IOException, ClassNotFoundException {
        String sql="update passage set passagePosition='"+passagePosition+"' where bookId="+bookId+" and passageNumber="+passageNumber+"";
        DBUtils dbUtils=new DBUtils();
        dbUtils.update(sql);
        dbUtils.close();
    }
    public void deletePassage(int bookId,int passageNumber) throws SQLException, IOException, ClassNotFoundException {
        String sql="delete from passage where bookId="+bookId+" and passageNumber="+passageNumber+"";
        DBUtils dbUtils=new DBUtils();
        dbUtils.update(sql);
        dbUtils.close();
    }
}
