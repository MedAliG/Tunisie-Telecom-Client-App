<?php
class user{
	private $conn;
	private $table = " users";

	private $id;
	private $phone;
	private $password;
	private $fullName;
	private $sold;
	private $sold_internet;
	private $fin_sold;
	private $fin_sold_internet;

	public function __construct($db){
		$this->conn = $db;
	}
	function login($phone,$psw){
		$query = "SELECT * FROM users where phone='".$phone."' AND password='".md5($psw)."'";
		
		$stmt = $this->conn->query($query);
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
		if($row['id'] != null){
				$userInfo = array(
					'id' => $row['id'],
					'phone' => $row['phone'],
					'fullName' => $row['fullName'],
					'sold' => $row['sold'],
					'sold_internet' => $row['sold_internet'],
					'fin_sold' => $row['fin_sold'],
					'fin_sold_internet' => $row['fin_sold_internet'],
				);
		}
		
		return $userInfo;
	}

	function getUsers(){
		$query = "SELECT * FROM users";
		$stmt = $this->conn->query($query);
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
		return $row;
	}
	function register($phone,$psw,$fullName){
		$psw = md5($psw);
		$valQuery = "SELECT count(*) as resultCount from users where phone='".$phone."'";
		$stmt = $this->conn->query($valQuery);
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
		if($row['resultCount'] == null || $row['resultCount'] != 0){
			return "Phone Number Taken plese try an other one";
		}else{
			try{
				$insertQuery = "INSERT INTO users (phone,password,fullName,sold,sold_internet,fin_sold,fin_sold_internet,bonus_days_left,bonus) VALUES ('".$phone."','".$psw."','".$fullName."',0,0,0,0,0,0)";
			//echo $insertQuery;
			$this->conn->exec($insertQuery);
				return "Success";

			}catch(PDOException $e){
				return "Connexion Failure";
			}



		}

	}	

	function userData($userPhone){
		$query = "SELECT * FROM users where phone='".$userPhone."'";

		$stmt = $this->conn->query($query);
		$row = $stmt->fetch(PDO::FETCH_ASSOC);
		if($row['id'] != null){
				$userInfo = array(
					'sold' => $row['sold'],
					'sold_internet' => $row['sold_internet'],
					'bonus' => $row['bonus'],
					'bonus_days_left' => $row['bonus_days_left'],
					'fin_sold' => $row['fin_sold'],
					'fin_sold_internet' => $row['fin_sold_internet'],
				);
		return $userInfo;	
		}else{
			return null;
		}
		
	}	
	
}



?>