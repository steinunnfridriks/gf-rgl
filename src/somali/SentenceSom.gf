concrete SentenceSom of Sentence = CatSom ** open
  TenseX, ResSom, (AS=AdverbSom), Prelude in {

flags optimize=all_subs ;

lin

--2 Clauses

  -- : NP -> VP -> Cl
  PredVP np vp = let compl = vp.comp ! np.a in {
    s = \\b =>
         if_then_Str np.isPron [] (np.s ! Nom)
      ++ compl.p1
      ++ case <b,vp.isPred,np.a> of { --sentence type marker + subj. pronoun
            <True,True,Sg3 _> => "waa" ;
      --      _                 => stmarker ! np.a ! b } -- marker+pronoun contract
            _ => case <np.isPron,b> of {
                   <True,True>  => "waa" ++ np.s ! Nom ; -- to force some string from NP to show in the tree
                   <True,False> => "ma"  ++ np.s ! Nom ;
                   <False>      => stmarkerNoContr ! np.a ! b
         }}
      ++ vp.adv.s
      ++ compl.p2            -- object pronoun for pronouns, empty for nouns
      ++ vp.s ! VPres np.a b -- the verb inflected
      ++ vp.adv.s2
    } ;
{-
  -- : SC -> VP -> Cl ;         -- that she goes is good
  PredSCVP sc vp = ;

--2 Clauses missing object noun phrases
  -- : NP -> VPSlash -> ClSlash ;
  SlashVP np vps = ;

  -- : ClSlash -> Adv -> ClSlash ;     -- (whom) he sees today
  AdvSlash cls adv = cls ** insertAdv adv cls ;

--    SlashPrep : Cl -> Prep -> ClSlash ;         -- (with whom) he walks

  -- : NP -> VS -> SSlash -> ClSlash ; -- (whom) she says that he loves
--  SlashVS np vs ss = {} ;


  --  : Temp -> Pol -> ClSlash -> SSlash ; -- (that) she had not seen
  UseSlash t p cls = UseCl t p (PredVP he_Pron cls) ;

--2 Imperatives
  -- : VP -> Imp ;
 ImpVP vp = { s = linVP vp } ;

--2 Embedded sentences


  -- : S  -> SC ;
  EmbedS s = { } ;

  -- : QS -> SC ;
  EmbedQS qs = { } ;

  -- : VP -> SC ;
  EmbedVP vp = { s = linVP vp } ;

--2 Sentences


  -- : Temp -> Pol -> Cl -> S ;
  UseCl temp pol cl = { s = cl.s ! temp.t ! temp.a ! pol.p ! Stat } ;

  -- : Temp -> Pol -> RCl -> RS ;
  UseRCl temp pol cl = { s = cl.s ! temp.t ! temp.a ! pol.p } ;

  -- : Temp -> Pol -> QCl -> QS ;
  UseQCl temp pol qcl = { s = qcl.s ! temp.t ! temp.a ! pol.p } ;

-- An adverb can be added to the beginning of a sentence, either with comma ("externally")
-- or without:

  -- : Adv -> S  -> S ;            -- then I will go home
  AdvS = advS ;

  -- : Adv -> S  -> S ;            -- next week, I will go home
  ExtAdvS adv = advS {s = adv.s ++ SOFT_BIND ++ ","}  ;

-- There's an SubjS already in AdverbSom -- should this be deprecated?
  -- : S -> Subj -> S -> S ;
  SSubjS s1 subj s2 = AdvS (AE.SubjS subj s2) s1 ;

-- A sentence can be modified by a relative clause referring to its contents.

  --  : S -> RS -> S ;              -- she sleeps, which is good
  RelS sent rs = advS { s = rs.s ! Sg3 Masc ++ SOFT_BIND ++ ","} sent ;

oper

  advS : Adv -> SS -> SS = \a,s -> {s = a.s ++ s.s} ;
-}
}
