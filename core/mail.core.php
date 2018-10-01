<?php
if (!defined('_MARICMS_')) exit;
include_once(MARI_MAIL_PATH.'/class.phpmailer.php');


function mail_ok($fname, $fmail, $to, $subject, $content, $type=0, $file="", $cc="", $bcc="") 
{ 
    global $config; 
    global $mari; 

    /*메일발송 사용여부*/
    if (!$config['c_email_use']) return; 

    if ($type != 1) 
        $content = nl2br($content); 

    $mail = new PHPMailer(); // defaults to using php "mail()"
    if (defined('MARI_SMTP') && MARI_SMTP) {
        $mail->IsSMTP(); // telling the class to use SMTP
        $mail->Host = MARI_SMTP; // SMTP server
    }
    $mail->From = $fmail;
    $mail->FromName = $fname;
    $mail->Subject = $subject;
    $mail->AltBody = ""; // optional, comment out and test
    $mail->MsgHTML($content);
    $mail->AddAddress($to);
    if ($cc) 
        $mail->AddCC($cc);
    if ($bcc) 
        $mail->AddBCC($bcc);
    //print_r2($file); exit;
    if ($file != "") { 
        foreach ($file as $f) { 
            $mail->AddAttachment($f['path'], $f['name']);
        }
    }
    return $mail->Send();
}

// 파일을 첨부함
function attach_file($filename, $tmp_name)
{
    // 서버에 업로드 되는 파일은 확장자를 주지 않는다. (보안 취약점)
    $dest_file = MARI_DATA_PATH.'/tmp/'.str_replace('/', '_', $tmp_name);
    move_uploaded_file($tmp_name, $dest_file);
    /*
    $fp = fopen($tmp_name, "r");
    $tmpfile = array(
        "name" => $filename,
        "tmp_name" => $tmp_name,
        "data" => fread($fp, filesize($tmp_name)));
    fclose($fp);
    */
    $tmpfile = array("name" => $filename, "path" => $dest_file);
    return $tmpfile;
}
?>