<?php
class Transfer{
	private $conn;
	private $table = "transferHistory";

	private $id;
	private $date;	
	private $senderId;
	private $receiverId;
	private $montant;

	public function __construct($db){
		$this->conn = $db;
	}

	function getSentHistory($userId){
		$query = "SELECT * FROM transferHistory where senderId = $userId";
		$stmt = $this->conn->prepare($query);
		$stmt->execute();
		$result = array();
		if($stmt->rowCount() > 0){
			$result['state'] = "Success";
			$result['resultSet'] = array();
			
			while($row = $stmt->fetch()){
				extract($row);

				$receiverId = $row['receiverId'];
				$receiverInfo = "SELECT * FROM users WHERE id = ".$receiverId."";
				$sts = $this->conn->query($receiverInfo);
				$forf = $sts->fetch(PDO::FETCH_ASSOC);

				$set = array(
					'id' => $row['id'],
					'date' => $row['date'],
					'receiverName' => $forf['fullName'],
					'receiverNumber' => $forf['phone'],
					'montant' => $row['montant']
				 );
				array_push($result['resultSet'], $set);
			}
			
		}else{
			$result = array('state' => 'error' );
		}
	return $result;
	}

	function getReceivedHistory($userId){
		$query = "SELECT * FROM transferHistory where receiverId = $userId";
		$stmt = $this->conn->prepare($query);
		$stmt->execute();
		$result = array();
		if($stmt->rowCount() > 0){
			$result['state'] = "Success";
			$result['resultSet'] = array();
			
			while($row = $stmt->fetch()){
				extract($row);

				$senderId = $row['senderId'];
				$receiverInfo = "SELECT * FROM users WHERE id = ".$senderId."";
				$sts = $this->conn->query($receiverInfo);
				$forf = $sts->fetch(PDO::FETCH_ASSOC);

				$set = array(
					'id' => $row['id'],
					'date' => $row['date'],
					'senderName' => $forf['fullName'],
					'senderPhone' => $forf['phone'],
					'montant' => $row['montant']
				 );
				array_push($result['resultSet'], $set);
			}
			
		}else{
			$result = array('state' => 'error' );
		}
	return $result;
	}


	function insertData($senderId,$receiverPhone,$montant){
		try{
			$montant = (float)$montant;
			$receiverInfo = "SELECT * FROM users WHERE phone = ".$receiverPhone."";
			$sts = $this->conn->query($receiverInfo);
			$forf = $sts->fetch(PDO::FETCH_ASSOC);

			$senderInfo = "SELECT * FROM users WHERE id=$senderId";
			$stss = $this->conn->query($senderInfo);
			$senderI = $stss->fetch(PDO::FETCH_ASSOC);

			if(isset($forf['id']) && $forf['id']!=null && $senderI['id']!=null && isset($senderI['id'])){
				$senderSold = (float)$senderI['sold'];
				if($senderSold < 0.5){
					$resultSet = array('state' => 'Sold inferieur a 0.5DT');
				}elseif($senderSold<$montant){
					$resultSet = array('state' => 'Sold insuffisant');
				}else{
					$senderNewSold = $senderSold - $montant;
					$senderUpdate = "UPDATE users SET sold = $senderNewSold where id = $senderId";
					//echo $senderUpdate;
					$this->conn->query($senderUpdate);

					$receiverId = $forf['id'];
					$receiverSold = $forf['sold'];
					$receiverNewSold = $receiverSold + $montant;
					$receiverUpdate = "UPDATE users SET sold = $receiverNewSold where id = $receiverId";
					//echo $receiverUpdate;
					$this->conn->query($receiverUpdate);
					
					$receiverId = $forf['id'];
					$query = "INSERT INTO transferhistory (senderId,receiverId,montant) VALUES(".$senderId.",".$receiverId.",".$montant.")";
					//echo $query;
					$this->conn->exec($query);
					
					$resultSet = array('state' => 'Successs');
				}
				

			}else{
				$resultSet = array('state' => 'NoUserError');
			}
			
		}catch(PDOException $e){
			$resultSet = array('state' => 'InsertionError');
		}
		return $resultSet;	
	}
}

?>