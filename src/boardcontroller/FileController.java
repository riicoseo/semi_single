package boardcontroller;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.file")
public class FileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		
		String cmd = uri.substring(ctxPath.length());
		
		if(cmd.contentEquals("/download.file")) {
			String oriName = request.getParameter("oriName");
			String sysName = request.getParameter("sysName");
			String filePath = request.getServletContext().getRealPath("files");
			
			File targetFile = new File(filePath+"/"+sysName);
			
			FileInputStream fis = new FileInputStream(targetFile);
			DataInputStream dis = new DataInputStream(fis);
			DataOutputStream dos = new DataOutputStream(response.getOutputStream());
			
			byte[] fileSpace = new byte[(int)targetFile.length()];
			dis.readFully(fileSpace);
			
			//oriName = new String(oriName.getBytes("utf-8"),"iso-8859-1");
			
			response.reset();
			response.setContentType("application/octet-stream");
			response.setHeader("content-disposition","attachment; filename=\""+oriName+"\"");
			
			dos.write(fileSpace);
			dos.flush();
		}
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
