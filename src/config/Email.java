package config;

import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import bean.Task;

public class Email {

	private Properties props;
	private Session session;
	private final String username = "skyzertms@gmail.com";
	private final String password = "Skynet123";
	private String bodyText = "";
    
	
	public Email() {
		props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "25");
        
        session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                   protected PasswordAuthentication getPasswordAuthentication() {
                      return new PasswordAuthentication(username, password);
                   }
                });
	}
	
	public boolean sendEmail(String recipient, String oldAssignedTo, String assignedTo, String assignedBy, String projectName, Task task) {
		
		 try {
			 	
			   String assigneeRow = "";
			   
			   if(oldAssignedTo == null) assigneeRow = assignedTo;
			   else assigneeRow = oldAssignedTo + " -> " + assignedTo;
			 
	           Message message = new MimeMessage(session);

	           message.setFrom(new InternetAddress(username, assignedBy));
	           message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
	           message.setSubject("[My Task] - " + task.getName());
	          
	           BodyPart messageBodyPart = new MimeBodyPart();
	           bodyText = "<p><span style=\"color: #808080;\">[Note: This is an automated email, please do not reply]</span></p>\r\n" + 
	        		"<p>"+ assignedBy +" made 1 update.</p>\r\n" + 
	           		"<hr />\r\n" + 
	           		"<p>Hi "+ assignedTo +",</p>\r\n" + 
	           		"<p>A task has been assigned to you.&nbsp;<br /><br /></p>\r\n" + 
	           		"<table style=\"border-collapse: collapse; width: 88.7573%; height: 188px; table-layout: fixed;\">\r\n" + 
	           		"<tbody>\r\n" + 
	           		"<tr style=\"height: 18px;\">\r\n" + 
	           		"<td style=\"width: 17.9394%; height: 18px; text-align: justify; line-height: 1.5;\" valign=\"top\"><strong>Project</strong></td>\r\n" + 
	           		"<td style=\"width: 69.1556%; height: 18px; line-height: 1.5; text-align: left;\" valign=\"top\">"+ projectName +"</td>\r\n" + 
	           		"</tr>\r\n" + 
	           		"<tr style=\"height: 18px;\">\r\n" + 
	           		"<td style=\"width: 17.9394%; height: 18px; text-align: justify; line-height: 1.5;\" valign=\"top\"><strong>Task</strong></td>\r\n" + 
	           		"<td style=\"width: 69.1556%; height: 18px; line-height: 1.5; text-align: left;\" valign=\"top\">"+ task.getName() +"</td>\r\n" + 
	           		"</tr>\r\n" + 
	           		"<tr style=\"height: 18px;\">\r\n" + 
	           		"<td style=\"width: 17.9394%; height: 18px; text-align: justify; line-height: 1.5;\" valign=\"top\"><strong>Description</strong></td>\r\n" + 
	           		"<td style=\"width: 69.1556%; height: 18px; line-height: 1.5; overflow-wrap: break-word; text-align: left;\" valign=\"top\">"+ task.getDescription() +"</td>\r\n" + 
	           		"</tr>\r\n" + 
	           		"<tr style=\"height: 18px;\">\r\n" + 
	           		"<td style=\"width: 17.9394%; height: 18px; text-align: justify; line-height: 1.5;\" valign=\"top\"><strong>Due Date</strong></td>\r\n" + 
	           		"<td style=\"width: 69.1556%; height: 18px; line-height: 1.5; text-align: left;\" valign=\"top\">"+ task.getDueDate() +"</td>\r\n" + 
	           		"</tr>\r\n" + 
	           		"<tr style=\"height: 18px;\">\r\n" + 
	           		"<td style=\"width: 17.9394%; height: 18px; text-align: justify; line-height: 1.5;\" valign=\"top\"><strong>Assignee</strong></td>\r\n" + 
	           		"<td style=\"width: 69.1556%; height: 18px; line-height: 1.5; text-align: left;\" valign=\"top\">"+ assigneeRow + "</td>\r\n" + 
	           		"</tr>\r\n" + 
	           		"<tr style=\"height: 18px;\">\r\n" + 
	           		"<td style=\"width: 17.9394%; height: 18px; text-align: justify; line-height: 1.5;\" valign=\"top\"><strong>Assigneed By</strong></td>\r\n" + 
	           		"<td style=\"width: 69.1556%; height: 18px; line-height: 1.5; text-align: left;\" valign=\"top\">"+ assignedBy +"</td>\r\n" + 
	           		"</tr>\r\n" + 
	           		"<tr style=\"height: 31px;\">\r\n" + 
	           		"<td style=\"width: 87.095%; text-align: justify; height: 31px;\" colspan=\"2\">&nbsp;</td>\r\n" + 
	           		"</tr>\r\n" + 
	           		"<tr style=\"height: 18px;\">\r\n" + 
	           		"<td style=\"height: 18px; text-align: justify;\" colspan=\"2\"><a style=\"margin-left: 10rem;\" href=\"http:\\10.63.192.13:8080\\MyTask\\\">Login to My Task</a></td>\r\n" + 
	           		"</tr>\r\n" + 
	           		"</tbody>\r\n" + 
	           		"</table>\r\n" + 
	           		"<p>&nbsp;</p>\r\n" + 
	           		"<p style=\"text-align: center;\"><span style=\"color: #808080;\">Designed &amp; Maintained by&nbsp;<a href=\"http://www.jaysolanki.tech\">Jay Solanki</a></span></p>";
	           messageBodyPart.setContent(bodyText, "text/html");
	           Multipart multipart = new MimeMultipart();
	           multipart.addBodyPart(messageBodyPart);
	          
	           message.setContent(multipart);
	           
	           // Email Synchronization 
	           ExecutorService emailExecutor = Executors.newCachedThreadPool();
	           emailExecutor.execute(new Runnable() {
	               @Override
	               public void run() {
	                   try {
	                	   Transport.send(message);
	                   } catch (Exception e) {
	                	   e.printStackTrace();
	                   }
	               }
	           });
	           
	           return true;
	           
	        } catch (Exception e) {
	        	e.printStackTrace();
	        	return false;
	        }
	}
}
