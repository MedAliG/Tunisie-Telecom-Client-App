<?php
class ForfaitHistory{
	private $conn;
	private $table = "forfaithistory";

	private $id;
	private $date;
	private $montant;
	private $code_utilise;
	private $userId;

	public function __construct($db){
		$this->conn = $db;
	}

	function getHistory($userId){
		$query = "SELECT * FROM forfaithistory where userId = $userId ORDER BY date DESC";
		$stmt = $this->conn->prepare($query);
		$stmt->execute();
		$result = array();
		if($stmt->rowCount() > 0){
			$result['state'] = "Success";
			$result['resultSet'] = array();
			
			while($row = $stmt->fetch()){
				extract($row);
				$forfaitid = $row['forfaitId'];
				$forfaitInfo = "SELECT * FROM forfait WHERE id = ".$forfaitid."";
				$sts = $this->conn->query($forfaitInfo);
				$forf = $sts->fetch(PDO::FETCH_ASSOC);

				$set = array(
					'id' => $row['id'],
					'date' => $row['date'],
					'forfaitMontant' => $forf['montant'],
					'forfaitDuree' => $forf['duree'],
					'forfaitPrix' => $forf['prix']
				 );
				array_push($result['resultSet'], $set);
			}
			
		}else{
			$result = array('state' => 'error' );
		}
	return $result;
	}

	function insertData($userId,$forfaitId){
		try{
			$query = "INSERT INTO forfaithistory (userId,forfaitId) VALUES($userId,$forfaitId)";
			echo $query;
			$this->conn->exec($query);
			$resultSet = array('state' => 'Successs');
		}catch(PDOException $e){
			$resultSet = array('state' => 'InsertionError');
		}
		return $resultSet;	
	}
}

?>