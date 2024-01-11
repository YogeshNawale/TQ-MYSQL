use  voterboothvoting;

-- a.	Write a query to  see details of FEMALE  senior citizen(age above 60) voters
-- 		  who stays in Deccan Gymkhana area of Pune City	

SELECT voterid, votername 
FROM voter v
INNER JOIN residenceaddress ra USING (VAddressId)
where v.VoterAge>60 AND ra.area='Deccan Gymkhana' AND ra.city='pune' AND v.gender= 'female';

-- b.	Write query to fetch City wise total male and total female voters.	

SELECT city, SUM(CASE WHEN V.Gender = 'Male' THEN 1 ELSE 0 END) AS TotalMaleVoters,
			  SUM(CASE WHEN V.Gender = 'Female' THEN 1 ELSE 0 END) AS TotalFemaleVoters
FROM voter v
INNER JOIN residenceaddress ra USING (VAddressId)
group by city;
 
 -- c.	Delete VotingMapper records if Election Date is before  Jan 2019 for Pune city.
 
DELETE FROM VotingMapper
WHERE ElectionDate < '2019-01-01' 
      AND State = 'Maharashtra' 
      AND BoothId IN (SELECT BoothId FROM BoothDetails WHERE City = 'Pune');
      
-- d.	Change Booth ID of All voters from Shivajinagar Voting area to 110.

UPDATE VotingMapper
SET BoothId = 110
WHERE VoterId IN (SELECT VoterId FROM Voter WHERE VotingArea = 'Shivajinagar');

call  UpdateBoothForSeniorCitizens(112, "Neha Shah", 10);

UPDATE VotingMapper  
SET BoothId = 111
WHERE VoterId IN (SELECT VoterId FROM (
        SELECT V.VoterId
        FROM Voter V
        JOIN VotingMapper VM ON V.VoterId = VM.VoterId
        WHERE V.VoterName = 'Neha Shah'
            AND V.VAddressId = 10
            AND V.VoterAge > 60
    ) AS subquery
);


SELECT vAadhar, rs.* 
FROM voter v, residenceaddress rs
where v.VAddressId =rs.VAddressId;