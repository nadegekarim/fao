DECLARE @TypeFormulaire nvarchar(20) ='Commerciaux'

SELECT a.Id as idEntretien, 
       a.ColleagueId as IdCollaborateur, 
	   a.ManagerId as IdManager, 
	   isnull(a.DelegateId,'') as IdDelegate,
	   isnull(a.DelegatePersoId,'') as PersoIdDelegate,
	   isnull(a.PreviousInterviewDate,'') as DateEntrPrecedent,
	   a.FormId as IdFormulaire,
	   iif(a.FormId = 00000001, 'Commerciaux', 'Support') as TypeFormulaire,
	   isnull(a.InterviewDate,'') as DatEntretien,
	   isnull(a.EvaluationPeriodStartDate,'') as PeriodeDebutDate,
	   isnull(a.EvaluationPeriodEndDate,'') as PeriodeFinDate,
	   b.Achieved as ObjectifAtteint,
	   b.NotAchieved as ObjectifNonAtteint,
	   b.ManagerComment as ObjectifCommentaireManager,
	   b.ColleagueComment as ObjectifCommentaireCollab
	   INTO #TmpEntretienObjectifPrec
	FROM dbo.Interview as a inner join dbo.GoalAnalysis as b on a.GoalAnalysisId = b.Id and a.Id = b.InterviewId
	ORDER BY a.Id

	SELECT a.*,
	b.Id as IdEvaluation ,
	b.LineId as IdAxeEvaluation
	INTO #TmpCommerciaux
	FROM #TmpEntretienObjectifPrec a inner join dbo.LineAnalysis b on a.idEntretien = b.InterviewId
	WHERE a.idEntretien = 'D7911AE0-8BF4-425A-95F1-00094B727B34'

	IF @TypeFormulaire ='Commerciaux' 
	BEGIN
	SELECT * 
	FROM #TmpCommerciaux
	END
	
	
