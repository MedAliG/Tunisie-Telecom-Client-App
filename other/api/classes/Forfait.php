<?php
class Forfait{
	private $conn;
	private $table = "forfait";

	private $id;
	private $montant;
	private $duree;
	private $prix;

	public function __construct($db){
		$this->conn = $db;
	}

	function allForfait(){
		$query = "SELECT * FROM forfait";
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
					'montant' => $row['montant'],
					'duree' => $row['duree'],
					'prix' => $row['prix']
				 );
				array_push($result['resultSet'], $set);
			}
			
		}else{
			$result = array('state' => 'error' );
		}
	return $result;
	}

	function achatForfait($userId,$forfaitId){

		$forfaitInfo = "SELECT * FROM forfait where id=$forfaitId";
		$stmt = $this->conn->query($forfaitInfo);
		$forfaitInfos = $stmt->fetch(PDO::FETCH_ASSOC);
		$forfaitPrice = (float)$forfaitInfos['prix'];
		$forfaitDuration = (int)$forfaitInfos['duree'];
		$forfaitMontant = (int)$forfaitInfos['montant'];

		$userInfo = "SELECT * FROM users WHERE id = $userId";
		$stm = $this->conn->query($userInfo);
		$userInfos = $stm->fetch(PDO::FETCH_ASSOC);
		
		$userSold = (float)$userInfos['sold'];
		$userSoldInternet = (int)$userInfos['sold_internet'];
		$userSoldInternetFin = (int)$userInfos['fin_sold_internet'];

		if($userSold < $forfaitPrice){
			$result = array('state' => 'Sold Insuffisant');
		}else{
			$newSold = $userSold-$forfaitPrice;
			$newSoldInternet = $userSoldInternet + $forfaitMontant;
			$newFinSoldInternet = $forfaitDuration;
			if($userSoldInternetFin > $forfaitDuration){
				$newFinSoldInternet = $userSoldInternetFin;
			}
			try{
				$updateQuery = "UPDATE users SET sold = $newSold ,sold_internet = $newSoldInternet, fin_sold_internet = $newFinSoldInternet WHERE id=$userId";
				//echo $updateQuery;

				$this->conn->exec($updateQuery);

				$insertionQuery = "INSERT INTO forfaithistory (forfaitId,userId) VALUES ($forfaitId,$userId)";
				
				$this->conn->exec($insertionQuery);

				$result = array('state' => 'Success');
			}catch(PDOException $e){
				$result = array('state' => 'InsertionErrorOrUpdateError');
			}
		}
		return $result;
	}
	
}

?>