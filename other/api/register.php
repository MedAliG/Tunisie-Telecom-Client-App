<?php


/** read file*/
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');
/** end read */

/**database file*/
include("classes/database.php");
/** end dbfile */

/* usersClass*/
include("classes/users.php");

/*Making a dbConnection to work on*/
$database = new database();
$db = $database->getConnection();
if(isset($_GET['token']) && $_GET['token'] == "5a773f9e8b9663b2918851ed6396feed63019b9a2f348cf69c9e96b3c0dbd960"){
	if(isset($_GET['phone']) && isset($_GET['password'])){
		$phone = $_GET['phone'];
		$password = $_GET['password'];
		$fullName = $_GET['fullName'];
		$user = new user($db);
		$stmt = $user->register($phone,$password,$fullName);
		
		if($stmt != null){
			$respond = array(
				'state' => 'Success',
				'userInfo' => $stmt ,
			);
			http_response_code(200);
			echo json_encode($respond);
		}else{
			echo json_encode(array('state' => 'RegisterError'));
			
		}
	}
}

?>