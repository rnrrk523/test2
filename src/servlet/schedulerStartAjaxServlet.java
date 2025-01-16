package servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

import scheduler.MyJob;

@WebServlet("/schedulerStartAjaxServlet")
public class schedulerStartAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static Scheduler scheduler = null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberCnt = Integer.parseInt(request.getParameter("memberCnt"));
		try {
            SchedulerFactory schedulerFactory = new StdSchedulerFactory();
            scheduler = schedulerFactory.getScheduler();
            
            JobDataMap jobDataMap = new JobDataMap();	
            jobDataMap.put("memberCnt", memberCnt);
            
            JobDetail jobDetail = JobBuilder.newJob(MyJob.class)
                                    .withIdentity("myJob", "group1")
                                    .usingJobData(jobDataMap)
                                    .build();

            CronTrigger cronTrigger = (CronTrigger) TriggerBuilder.newTrigger()
                                    .withIdentity("trggerName", "cron_trigger_group")
                                    .withSchedule(CronScheduleBuilder.cronSchedule("0/20 * * * * ?")) // 매 20초마다 실행
                                    .forJob(jobDetail)
                                    .build();

            Set<Trigger> triggerSet = new HashSet<Trigger>();
            triggerSet.add(cronTrigger);

            scheduler.scheduleJob(jobDetail, triggerSet, false);
            
            scheduler.start();
            //scheduler.shutdown();
            
//           Date now = new Date();
//           SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
//           System.out.println("job이 실행됨. : "+formatter.format(now)+" / "+memberCnt+"명에게 포인트부여(1점).");
        } catch(Exception e) {
            e.printStackTrace();
        }
	}
}
