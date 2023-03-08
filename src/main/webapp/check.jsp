<%-- 
    Document   : Check
    Created on : Jun 30, 2022, 11:48:57 PM
    Author     : Acer
--%>

<%@page import="java.sql.*"%>
<%@page import="java.io.FileOutputStream"%>
<%--<%@page import="com.itextpdf.text.Document"%>  
<%@page import="com.itextpdf.text.pdf.PdfWriter"%> 
<%@page import="com.itextpdf.text.Paragraph"%>--%>
<%@page import="com.mycompany.idrsproject.DBConnection" %>
<%@page import="java.util.Random" %>



<%
    Connection connection = null;
    try {
        connection = DBConnection.getConnection();
        if (connection != null) {
            out.println("Database Connected.");

        } else {
            out.println("Database Connect Failed.");
        }

    } catch (Exception e) {
        // TODO Auto-generated catch block
        out.println(e.getMessage());
        e.printStackTrace();
    }
    String action = request.getParameter("action");
    if (action.equals("register")) {
        try {
            String sql = "INSERT INTO user(`First Name`,`Last Name`,`Email`,`Phone Number`,`Nationality`) VALUES(?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, request.getParameter("fname"));
            ps.setString(2, request.getParameter("lname"));
            ps.setString(3, request.getParameter("email"));
            ps.setString(4, request.getParameter("phone"));
            ps.setString(5, request.getParameter("nation"));
            int executeUpdate = ps.executeUpdate();
            if (executeUpdate != 0) {
                out.println("User Add Successfully");
            } else {
                out.println("Failed to submit the user");
            }
            // Create a Random object
            Random random = new Random();
            String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < 12; i++) {
                int index = random.nextInt(characters.length());
                char randomChar = characters.charAt(index);
                sb.append(randomChar);
            }
            String randomString = sb.toString();
            String sql1 = "INSERT INTO payment(payment_id,payment_email,payment_promoid,payment_status,invoice_no) VALUES(?,?,?,?,?)";
            PreparedStatement ps1 = connection.prepareStatement(sql1);
            ps1.setString(1, request.getParameter("fname") + " " + request.getParameter("lname"));
            ps1.setString(2, request.getParameter("email"));
            ps1.setString(3, request.getParameter("planid"));
            ps1.setString(4, "not paid");
            ps1.setString(5, randomString);
            int executeUpdate1 = ps1.executeUpdate();
            if (executeUpdate1 != 0) {
                out.println("Payment Add Successfully");
            } else {
                out.println("Failed to submit the payment");
            }

//            int i = statement.executeUpdate("insert into user values ('" + fname + "','" + fname + "','" + lname + "','" + email + "','" + phone + "','" + nation + "')");
            //in case mahidol recive money//
            //int j=st.executeUpdate("insert into payment values ('"+fname+"','"+email+"','"+planid+"','wait','wait','wait','wait')");
//            int j = statement.executeUpdate("insert into payment values('" + fname + "','" + email + "','" + planid + "','Suscess','wait','wait','wait')");
//                try{
//                    String file_name = "C:\\Users\\Acer\\Documents\\NetBeansProjects\\WebApplication1\\web\\gen_result\\"+email+".pdf";
//                    Document document = new Document();
//
//                    PdfWriter.getInstance(document,new FileOutputStream(file_name));
//
//                    document.open();
//
//                    Paragraph para = new Paragraph("This is IDS_test gen file of "+fname+"_"+lname+"");
//                    document.add(para);
//                    document.close();
//                    response.sendRedirect("qr_gen.jsp");
//               
            response.sendRedirect("2c2p.jsp?invoice_no=" + randomString + "");
//                    
//                } catch (Exception e) {
//                                System.err.println(e);
//                }

//            if(!planid.equals("non_member")){}
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            out.println(e.getMessage());
            e.printStackTrace();

//                        response.sendRedirect("index.jsp");
        }

        //String action=request.getParameter("action");
        //if (action.equals("login")) {
        // String fname = request.getParameter("fname");
        //String lname = request.getParameter("lname");
        //if(fname.equals("ice")&& lname.equals("123")){
        //session.setAttribute("username",lname);
        //response.sendRedirect("main.jsp");} 
    }
%>

