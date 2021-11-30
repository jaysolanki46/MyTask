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

public class GuideEmail {

	private Properties props;
	private Session session;
	private final String username = "skyzertms@gmail.com";
	private final String password = "Skynet123";
	private String bodyText = "";
    
	
	public GuideEmail() {
		props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "25");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                   protected PasswordAuthentication getPasswordAuthentication() {
                      return new PasswordAuthentication(username, password);
                   }
                });
	}
	
	public boolean sendEmailOnUserActivation(String recipient, String username) {
		
		try {
		 	
	           Message message = new MimeMessage(session);

	           message.setFrom(new InternetAddress(username, "Skyzer Technologies"));
	           message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
	           message.setSubject("SKYZER GUIDE | Congratulations!");
	          
	           BodyPart messageBodyPart = new MimeBodyPart();
	           bodyText = this.sendEmailOnUserActivationBody(username);
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
	
	private String sendEmailOnUserActivationBody(String username) {
		return "<p><span style='font-size:16px;font-family:\"Verdana\",sans-serif;color:#333333;background:white;'><span style='color: rgb(51, 51, 51); font-family: \"Verdana\", sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;'>Dear "+ username +",&nbsp;</span>&nbsp;</span></p>\r\n" + 
				"<p><span style='font-size:16px;font-family:\"Verdana\",sans-serif;color:#333333;background:white;'><span style='color: rgb(51, 51, 51); font-family: \"Verdana\", sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;'>Congratulations! Your account has been successfully activated.</span></span><br><br></p>\r\n" + 
				"<p><span style='color: rgb(51, 51, 51); font-family: \"Verdana\", sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;'>We appreciate your patience!&nbsp;</span></p>\r\n" + 
				"<p><span style='font-size:16px;font-family:\"Verdana\",sans-serif;color:#333333;background:white;'><span style='color: rgb(51, 51, 51); font-family: \"Verdana\", sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;'>Thank you for choosing Skyzer, enjoy!!</span></span></p>\r\n" + 
				"<p><br><span style='color: rgb(51, 51, 51); font-family: \"Verdana\", sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;'>Kind regards,</span><br><span style='color: rgb(51, 51, 51); font-family: \"Verdana\", sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;'>Team Skyzer</span></p>\r\n" + 
				"<p style='margin:0cm;font-size:15px;font-family:\"Verdana\",sans-serif;'><br></p>\r\n" + 
				"<p style=\"font-size:12px;font-family:Verdana,sans-serif;color:#97999C;\">[If you have any questions, please contact us at <a href=\"mailto:support@skyzer.co.nz?subject=Skyzer\">support@skyzer.co.nz</a> or call us on <a href=\"tel:+64 9 259 0322\" target=\"_self\">+64 9 259 0322</a>]</p>";
	}
}
