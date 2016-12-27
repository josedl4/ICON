;;; Plantillas de un implemenmtación OAV con factor de incertudumbre en CLIPS

;;; Plantillas para hechos-univaluados
(deftemplate oavc-u
  (slot objeto    (type SYMBOL))
  (slot atributo  (type SYMBOL))
  (slot valor)
  (slot factor    (type FLOAT)
                  (range -1.0 1.0)))

;;; Plantillas para hechos-multivaluados
(deftemplate oavc-m
  (slot objeto    (type SYMBOL))
  (slot atributo  (type SYMBOL))
  (slot valor)
  (slot factor    (type FLOAT)
                  (range -1.0 +1.0)))

;;; Permitimos la duplicación de hechos
(defrule duplicar-hechos
  (declare (salience 10000))

  =>

  (set-fact-duplication TRUE))


;;; 
(defrule garantizar-univaluados
  (declare (salience 9000))
  ?f1 <- (oavc-u (objeto ?o1) (atributo ?a1))
  ?f2 <- (oavc-u (objeto ?o1) (atributo ?a1))
                  (test (neq ?f1 ?f2))
  =>

  (retract ?f2))
