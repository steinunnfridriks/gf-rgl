--# -path=.:../abstract:../common:prelude
concrete ExtendBul of Extend = CatBul ** open Prelude, ResBul, StructuralBul in {

lin
  AdAdV = cc2 ;

  EmptyRelSlash slash = {
      s = \\t,a,p,agr => slash.c2.s ++ whichRP ! agr.gn ++ slash.s ! agr ! t ! a ! p ! Main ;
      role = RObj Acc
      } ;

  CompoundN n1 n2 = 
    let aform = ASg (case n2.g of {
                       AMasc _       => Masc ;
                       AFem          => Fem ;
                       ANeut         => Neut
                    }) Indef
    in {
         s   = \\nf => case n1.relPost of {
                         True  => n2.s ! (indefNForm nf) ++ n1.rel ! nform2aform nf n2.g ;
                         False => n1.rel ! nform2aform nf n2.g ++ n2.s ! indefNForm nf
                       } ;
         rel = \\af => n1.rel ! aform ++ n2.s ! NF Sg Indef ;  relPost = n1.relPost ;
         g   = n2.g
    } ;

  PositAdVAdj a = {s = a.adv} ;

  PresPartAP vp =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Imperf ! VPresPart aform ++
                          case vp.vtype of {
                            VMedial c => reflClitics ! c;
                            _           => []
                          } ++
                          vp.compl ! {gn=aform2gennum aform; p=p} ;
    in {s = ap; adv = ap ! (ASg Neut Indef) ! P3; isPre = vp.isSimple} ;

  PastPartAP vp =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Perf ! VPassive aform ++
                          vp.compl1 ! {gn=aform2gennum aform; p=p} ++
                          vp.compl2 ! {gn=aform2gennum aform; p=p}
    in {s = ap; adv = ap ! ASg Neut Indef ! P3; isPre = vp.isSimple} ;

  PastPartAgentAP vp np =
    let ap : AForm => Person => Str
           = \\aform,p => vp.ad.s ++
                          vp.s ! Perf ! VPassive aform ++
                          vp.compl1 ! {gn=aform2gennum aform; p=p} ++
                          vp.compl2 ! {gn=aform2gennum aform; p=p} ++
                          "от" ++ np.s ! RObj Acc
    in {s = ap; adv = ap ! ASg Neut Indef ! P3; isPre = False} ;

  GerundNP vp = {
    s = \\_ => daComplex Simul Pos vp ! Imperf ! {gn=GSg Neut; p=P1};
    a = {gn=GSg Neut; p=P3};
    p = Pos
  } ;

  GerundAdv vp =
    {s = vp.ad.s ++
         vp.s ! Imperf ! VGerund ++
         vp.compl ! {gn=GSg Neut; p=P3}} ;

  iFem_Pron      = mkPron "аз" "мен" "ме" "ми" "мой" "моя" "моят" "моя" "моята" "мое" "моето" "мои" "моите" (GSg Fem)  P1 ;
  youFem_Pron    = youSg_Pron ;
  weFem_Pron     = we_Pron ;
  youPlFem_Pron  = youPl_Pron ;
  theyFem_Pron   = they_Pron ;
  youPolFem_Pron = youPol_Pron ;
  youPolPl_Pron  = youPol_Pron ;
  youPolPlFem_Pron = youPol_Pron ;

}
