package scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import Dao.MemberDao;

public class MyJob implements Job {
    @Override
    public void execute(JobExecutionContext ctx) throws JobExecutionException {
    	Date now = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
    	int memberCnt = ctx.getMergedJobDataMap().getInt("memberCnt");
    	System.out.println("job이 실행됨. : "+formatter.format(now)+" / "+memberCnt+"명에게 포인트부여(1점).");
    	
    	MemberDao mDao = new MemberDao();
    	try {
			mDao.setMemberPoint();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}