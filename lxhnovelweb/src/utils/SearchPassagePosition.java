package utils;

import bean.Passage;
import dao.PassageDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

public class SearchPassagePosition {
    public static int searchPassagePosition(Passage passage) throws SQLException, IOException, ClassNotFoundException {
        ArrayList<Passage> passageArrayList=new ArrayList<>();
        passageArrayList=new PassageDAO().getAllPassageById(passage.getBookId());
        int position = -1;
        for(int i=0;i<passageArrayList.size();i++){
            if(passage.getPassageNumber()==passageArrayList.get(i).getPassageNumber()){
                position=i;
            }
        }
        return position;
    }
    public static Passage getNextPassage(Passage passage) throws SQLException, IOException, ClassNotFoundException {
        ArrayList<Passage> passageArrayList=new ArrayList<>();
        passageArrayList=new PassageDAO().getAllPassageById(passage.getBookId());
        if(passageArrayList.size()<1)
            return null;
        int position=-1;
        position=SearchPassagePosition.searchPassagePosition(passage);
        position=position+1;
        if(position>=passageArrayList.size())
            position=passageArrayList.size()-1;
        return passageArrayList.get(position);
    }
    public static Passage getLastPassage(Passage passage) throws SQLException, IOException, ClassNotFoundException {
        ArrayList<Passage> passageArrayList=new ArrayList<>();
        passageArrayList=new PassageDAO().getAllPassageById(passage.getBookId());
        if(passageArrayList.size()<1)
            return null;
        int position=-1;
        position=SearchPassagePosition.searchPassagePosition(passage);
        position=position-1;
        if(position<=0)
            position=passageArrayList.size()-1;
        return passageArrayList.get(position);
    }
}
