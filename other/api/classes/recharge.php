<?php
class Recharge{
	private $conn;
	private $table = "recharge";

	private $id;
	private $date;
	private $montant;
	private $code_utilise;
	private $userId;

	public function __construct($db){
		$this->conn = $db;
	}

	function getHistory($userId){
		$query = "SELECT * FROM recharge where userId = $userId ORDER BY date DESC";
		$stmt = $this->conn->prepare($query);
		$stmt->execute();
		$result = array();
		if($stmt->rowCount() > 0){
			$result['state'] = "Success";
			$result['resultSet'] = array();
			
			while($row = $stmt->fetch()){
				extract($row);
				$set = array(
					'id' => $row['id'],
					'date' => $row['date'],
					'montant' => $row['montant'],
					'code_utilise' => $row['code_utilise']
				 );
				array_push($result['resultSet'], $set);
			}
			
		}else{
			$result = array('state' => 'error' );
		}
	return $result;
	}
	function insertData($userId,$montant,$code_utilise){
		try{
			$query = "INSERT INTO recharge (montant,code_utilise,userId) VALUES(".$montant.",'".$code_utilise."',".$userId.")";
			$this->conn->exec($query);
			$resultSet = array('state' => 'Successs');
		}catch(PDOException $e){
			$resultSet = array('state' => 'InsertionError');
		}
		return $resultSet;	
	}
}

?>