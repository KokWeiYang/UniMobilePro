<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/hubbuddi/public_html/269971/countmee/php/PHPMailer/Exception.php';
require '/home8/hubbuddi/public_html/269971/countmee/php/PHPMailer/PHPMailer.php';
require '/home8/hubbuddi/public_html/269971/countmee/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$email=$_POST['email'];
$newpass=$_POST['newpass'];
$conpass=$_POST['conpass'];
$otp2=rand(1000,9999);

if($newpass === $conpass){
$sqlforgetp = "SELECT * FROM tbl_user WHERE email= '$email' AND otp1 = '0'";
$result = $conn-> query ($sqlforgetp);
	if($result ->num_rows>0){
		$sqlchange= "UPDATE tbl_user SET otp2='$otp2' WHERE email='$email'";
		if($conn->query($sqlchange)===TRUE){
			echo 'success';
			sendEmail($email,$otp2,$newpass);
		}
		else{
			echo 'failed';
		}
	}else{
		echo 'failed2';
	}
}else{
	echo 'failed1';
	}



function sendEmail($email,$otp2,$newpass){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug=0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host='mail.hubbuddies.com';                          //Set the SMTP server to send through
    $mail->SMTPAuth=true;                                           //Enable SMTP authentication
    $mail->Username='countmee@hubbuddies.com';                  //SMTP username
    $mail->Password='mj[X-](HUZO1';                                 //SMTP password
    $mail->SMTPSecure='tls';         
    $mail->Port=587;
    
    $from = "countmee@hubbuddies.com";
    $to = $email;
    $subject = "From CountMee. Please Verify your new password";
    $message = "Hi,<br><br>
    
	            Our system get that you need to change your password.<br><br>
	            
				
                If this is your operation, click the following link to verify your new password<br><br><a href='https://hubbuddies.com/269971/countmee/php/verify_password.php?email=".$email."&key=".$otp2."&newpass=".$newpass."'>Click Here</a><br><br>
				
				<strong>**If this is not your operation, send the problem to our email.**</strong>
				";
                
    $mail->setFrom($from,"CountMee");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}


?>