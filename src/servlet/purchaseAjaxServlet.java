package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import Dao.MemberDao;
import Dto.MemberDto;

@WebServlet("/purchaseAjaxServlet")
public class purchaseAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int price = Integer.parseInt(request.getParameter("price"));
		String id = request.getParameter("id");
		String yn = "N";
		MemberDao mDao = new MemberDao();
		MemberDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfo(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int point = memberInfo.getPoint();
		int result = 0;
		if(price <= point) {
			result = point - price;
			yn = "Y";
		}
		
		try {
			mDao.setPoint(id, result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		obj.put("yn", yn);
		out.println(obj);
	}
}