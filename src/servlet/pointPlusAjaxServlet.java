package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.MemberDao;
import Dto.MemberDto;

@WebServlet("/pointPlusAjaxServlet")
public class pointPlusAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int plus = Integer.parseInt(request.getParameter("plus"));
		String id = request.getParameter("id");
		
		MemberDao mDao = new MemberDao();
		MemberDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfo(id);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		int result = memberInfo.getPoint() + plus;
		
		try {
			mDao.setPoint(id, result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
