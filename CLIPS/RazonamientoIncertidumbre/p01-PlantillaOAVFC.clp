;;; Plantilla modelo objeto-atributo-valor con factor de incertidumbre 

; Plantilla - Hechos univaludos
(deftemplate oav-u "Hecho univaluado"
  (slot objeto (type SYMBOL))
  (slot atributo(type SYMBOL))
  (slot valor)
)

; Plantilla - Hechos multivaluados
(deftemplate oav-m "Hecho multivaluado"
  (slot objeto (type SYMBOL))
  (slot atributo(type SYMBOL))
  (multislot valor)
)

; Garantizar univaludos
(defrule hechos-univaluados
  (declare (salience 9000))
  ?ob1 <- (oav-u  (objeto   ?n1)
                  (atributo ?a1)
                  (valor    ?v1))
  ?ob2 <- (oav-u  (objeto   ?n1)
                  (atributo ?a1)
                  (valor    ?v2 & :(neq ?v1 ?v2)))
  =>
  (retract ?ob2))

;;; Acumulacion de hechos
(defrule permitirAcumulacion
	(declare (salience 10000))

  =>

  (set-fact-duplication TRUE)
)

; Positivos
(defrule positivosU
	(declare (salience 10000))
	?fact1 	<- (oavc-u (objeto ?o)
			(atributo ?a)
		        (valor ?v)
		        (factor ?f1&:(>= ?f1 0)&:(< ?f1 1)))
	?fact2 	<- (oavc-u (objeto ?o)
		        (atributo ?a)
		        (valor ?v)
		        (factor ?f2&:(>= ?f2 0)&:(< ?f2 1)))
	(test	(neq ?fact1 ?fact2))
=>
	(retract ?fact1)
	(bind ?f3 (+ ?f1 (* ?f2 (- 1 ?f1))))
	(modify ?fact2 (factor ?f3))
)

(defrule positivosM
	(declare (salience 10000))
	?fact1 	<- (oavc-m (objeto ?o)
			(atributo ?a)
		        (valor ?v)
		        (factor ?f1&:(>= ?f1 0)&:(< ?f1 1)))
	?fact2 	<- (oavc-m (objeto ?o)
		        (atributo ?a)
		        (valor ?v)
		        (factor ?f2&:(>= ?f2 0)&:(< ?f2 1)))
	(test	(neq ?fact1 ?fact2))
=>
	(retract ?fact1)
	(bind ?f3 (+ ?f1 (* ?f2 (- 1 ?f1))))
	(modify ?fact2 (factor ?f3))
)

; Negativos
(defrule negativosU
	(declare (salience 10000))
        ?fact1  <- (oavc-u (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f1&:(<= ?f1 0)&:(> ?f1 -1)))
        ?fact2  <- (oavc-u (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f2&:(<= ?f2 0)&:(> ?f2 -1)))
        (test   (neq ?fact1 ?fact2))
=>
  (retract ?fact1)
  (bind ?f3 (+ ?f1 (* ?f2 (+ 1 ?f1))))
  (modify ?fact2 (factor ?f3))
)

(defrule negativosM
	(declare (salience 10000))
        ?fact1  <- (oavc-m (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f1&:(<= ?f1 0)&:(> ?f1 -1)))
        ?fact2  <- (oavc-m (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f2&:(<= ?f2 0)&:(> ?f2 -1)))
        (test   (neq ?fact1 ?fact2))
=>
  (retract ?fact1)
  (bind ?f3 (+ ?f1 (* ?f2 (+ 1 ?f1))))
  (modify ?fact2 (factor ?f3))
)

; Positivo - Negativo
(defrule positivo_negativoU
	(declare (salience 10000))
        ?fact1  <- (oavc-u (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f1&:(>= ?f1 0)&:(< ?f1 1)))
        ?fact2  <- (oavc-u (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f2&:(<= ?f2 0)&:(> ?f2 -1)))
        (test   (neq ?fact1 ?fact2))
=>
  (retract ?fact1)
  (bind ?f3 (/ (+ ?f1 ?f2) (- 1 (min (abs ?f1) (abs ?f2)))))
  (modify ?fact2 (factor ?f3))
)

(defrule positivo_negativoM
	(declare (salience 10000))
        ?fact1  <- (oavc-m (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f1&:(>= ?f1 0)&:(< ?f1 1)))
        ?fact2  <- (oavc-m (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f2&:(<= ?f2 0)&:(> ?f2 -1)))
        (test   (neq ?fact1 ?fact2))
=>
  (retract ?fact1)
  (bind ?f3 (/ (+ ?f1 ?f2) (- 1 (min (abs ?f1) (abs ?f2)))))
  (modify ?fact2 (factor ?f3))
)

; Valor 1
(defrule univaluado1
	(declare (salience 10000))
        ?fact1  <- (oavc-u (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor 1.0))
        ?fact2  <- (oavc-u (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f2&:(< ?f2 1)))
=>
  (retract ?fact2)
)

(defrule multivaluado1
	(declare (salience 10000))
        ?fact1  <- (oavc-m (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor 1.0))
        ?fact2  <- (oavc-m (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f2&:(< ?f2 1)))
=>
  (retract ?fact2)
)

; Valor -1
(defrule univaluado-1
	(declare (salience 10000))
        ?fact1  <- (oavc-u (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor -1.0))
        ?fact2  <- (oavc-u (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f2&:(> ?f2 -1)))
=>
  (retract ?fact2)
)

(defrule multivaluado-1
	(declare (salience 10000))
        ?fact1  <- (oavc-m (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor -1.0))
        ?fact2  <- (oavc-m (objeto ?o)
                        (atributo ?a)
                        (valor ?v)
                        (factor ?f2&:(> ?f2 -1)))
=>
  (retract ?fact2)
)
