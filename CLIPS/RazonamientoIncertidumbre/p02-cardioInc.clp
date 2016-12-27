;;; SP Cardio - Factores de Certeza

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

;;; Datos de Pacientes.
(deffacts marta
  (oavc-u (objeto marta)
				  (atributo sexo)
		      (valor mujer)
		      (factor 1.0))

	(oavc-u	(objeto marta)
				  (atributo edad)
		      (valor 12)
		      (factor 1.0))

	(oavc-u	(objeto marta)
				  (atributo peso)
		      (valor obeso)
          (factor 1.0))

	(oavc-m	(objeto marta)
	      	(atributo sintomas)
	      	(valor fiebre)
		      (factor 0.6))

	(oavc-m	(objeto marta)
				  (atributo evidencia)
		      (valor rumorSistolico)
		      (factor 0.8))

	(oavc-u	(objeto marta)
				  (atributo presionSistolica)
		      (valor 150)
			    (factor 1.0))

	(oavc-u	(objeto marta)
				  (atributo presionDiastolica)
		      (valor 60)
		      (factor 1.0))
)

(deffacts luis
  (oavc-u 	(objeto luis)
            (atributo sexo)
            (valor hombre)
            (factor 1.0))

  (oavc-u	  (objeto luis)
            (atributo edad)
            (valor 49)
            (factor 1.0))

  (oavc-u	  (objeto luis)
            (atributo peso)
            (valor obeso)
            (factor 0.5))

  (oavc-m	  (objeto luis)
            (atributo sintomas)
            (valor dolorAbdominal)
            (factor 0.7))

  (oavc-m   (objeto luis)
            (atributo sintomas)
            (valor calambresPiernas)
            (factor 0.6))

  (oavc-m   (objeto luis)
            (atributo evidencia)
            (valor rumorAbdominal)
            (factor 0.6))

 (oavc-m    (objeto luis)
            (atributo evidencia)
            (valor masaPulsanteAbdomen)
            (factor 0.8))

  (oavc-u	  (objeto luis)
            (atributo presionSistolica)
            (valor 130)
            (factor 1.0))

  (oavc-u	  (objeto luis)
            (atributo presionDiastolica)
            (valor 90)
            (factor 1.0))
)

(deffacts andres
  (oav-u  (objeto andres)
          (atributo sexo)
          (valor hombre)
          (factor 1.0))

  (oav-u  (objeto andres)
          (atributo edad)
          (valor 52)
          (factor 1.0))

  (oavc-u	(objeto andres)
          (atributo peso)
          (valor obeso)
          (factor 0.7))

   (oavc-m  (objeto andres)
            (atributo sintomas)
            (valor calambresPiernas)
            (factor 1.0))

  (oavc-m   (objeto andres)
            (atributo evidencia)
            (valor fumador15)
            (factor 1.0))

   (oavc-u	(objeto Andres)
            (atributo presionSistolica)
            (valor 125)
            (factor 1.0))
   (oavc-u	(objeto Andres)
            (atributo presionDiastolica)
            (valor 85)
            (factor 1.0))
)

;;; Reglas de Diagnosis

; 0- Paciente de Riesgo
; Tenemos tres posibles opciones para considerar aun paciente como
; paciente de riesgo, si se cumple cualquiera de ellas, calificaremos al
; paciente como un paciente potencialmente de riesgo
(defrule pacienteRiesgo_Opcion1
	(declare (salience 700))
	(oavc-u	(objeto ?objeto)
				(atributo peso)
				(valor obeso)
				(factor ?fo&:(> ?fo 0.2)))
=>
	(bind ?f (* ?fo 0.8))
	(assert	(oavc-m 	(objeto ?objeto)
							(atributo condicion)
							(valor pacienteRiesgo)
							(factor ?f)))
)

(defrule pacienteRiesgo_Opcion2
	(declare (salience 700))
	(oavc-m 	(objeto ?objeto)
				(atributo evidencia)
				(valor fumador15)
				(factor ?ff&:(> ?ff 0.2)))
=>
	(bind ?f (* ?ff 0.8))
	(assert 	(oavc-m 	(objeto ?objeto)
							(atributo condicion)
							(valor pacienteRiesgo)
							(factor ?f)))
)

(defrule pacienteRiesgo_Opcion3
	(declare (salience 700))
	(oavc-m 	(objeto ?objeto)
				(atributo evidencia)
				(valor edad50)
				(factor ?fe&:(> ?fe 0.2)))
=>
	(bind ?f (* ?fe 0.8))
	(assert 	(oavc-m 	(objeto ?objeto)
							(atributo condicion)
							(valor pacienteRiesgo)
							(factor ?f)))
)

(deffunction fEdadMas50(?a)
	(if (<= ?a 48) then
		-1.0
	else
	(if (<= ?a 55) then
		0.6
	else
		1.0))
)

(defrule edadMas50
	(declare (salience 800))
	(oavc-u 	(objeto ?objeto)
				(atributo edad)
				(valor ?a)
				(factor ?fa&:(> ?fa 0.2)))
=>
	(bind ?fo (fEdadMas50 ?a))
	(bind ?f (*  ?fo ?fa))
	(assert (oavc-m 	(objeto ?objeto)
							(atributo evidencia)
							(valor edad50)
							(factor ?f)))
)

; 1- Aneurisma de Arteria Abdominal
(defrule AneurismaArteriaAbdominal
         (oavc-m  (objeto ?x)
                	(atributo sintomas)
                	(valor dolorAbdominal)
                	(factor ?f1))
         (oavc-m  (objeto ?x)
                	(atributo evidencia)
                	(valor rumorAbdominal)
                	(factor ?f2))
         (oavc-m  (objeto ?x)
                	(atributo evidencia)
                	(valor  masa-pulsante-abdomen)
                	(factor ?f3))
         (test (> (min ?f1 ?f2 ?f3) 0.2))
=>
         (bind ?f (* (min ?f1 ?f2 ?f3) 0.8))
         (assert (oavc-m  	(objeto ?x)
                        	  (atributo diagnostico)
                        	  (valor aneurismaArteriaAbdominal)
                        	  (factor ?f)))
)

; 2- Regurgitacion Aortica
(defrule pulso
	(oavc-u	(objeto ?x)
	  			(atributo presionSistolica)
		      (valor ?ps)
				  (factor ?fps&:(> ?fps 0.2)))
	(oavc-u	(objeto ?x)
				(atributo presionDiastolica)
				(valor ?pd)
				(factor ?fpd&:(> ?fpd 0.2)))
=>
	(bind ?fpp (* (min ?fps ?fpd) 1))
	(bind ?pp (- ?ps ?pd))
	(assert	(oavc-u	(objeto ?x)
							(atributo presionPulso)
							(valor ?pp)
							(factor ?fpp)))
)

(defrule regurgitacionAorticaRumorSistolico
	(oavc-u		(objeto ?x)
	  				(atributo presionSistolica)
		        (valor ?ps&:(> ?ps 140))
					  (factor ?fps&:(> ?fps 0.2)))
	(oavc-u		(objeto ?x)
					  (atributo presionPulso)
					  (valor ?pp&:(> ?pp 50))
					  (factor ?fpp&:(> ?fpp 0.2)))
	(oavc-m  	(objeto ?x)
					  (atributo evidencia)
					  (valor rumorSistolico)
					  (factor ?frs&:(> ?frs 0.2)))
=>
	(bind ?fra (* (min ?fps ?fpp ?frs) 0.7))
	(assert	(oavc-m	(objeto ?x)
							(atributo diagnostico)
							(valor regurgitacionAortica)
							(factor ?fra)))
)

(defrule regurgitacionAorticaDilatacionCorazon
	(oavc-u		(objeto ?x)
	  				(atributo presionSistolica)
					(valor ?ps&:(> ?ps 140))
					(factor ?fps&:(> ?fps 0.2)))
	(oavc-u		(objeto ?x)
					(atributo presionPulso)
					(valor ?pp&:(> ?pp 50))
					(factor ?fpp&:(> ?fpp 0.2)))
	(oavc-m  	(objeto ?x)
					(atributo evidencia)
					(valor dilatacionCorazon)
					(factor ?fdc&:(> ?fdc 0.2)))
=>
	(bind ?fra (* (min ?fps ?fpp ?fdc) 0.7))
	(assert	(oavc-m	(objeto ?x)
							(atributo diagnostico)
							(valor regurgitacionAortica)
							(factor ?fra)))
)

; 3- Estenosis en Arteria de la Pierna
(defrule estenosis-arteria-pierna
	(oavc-m 	(objeto ?x)
	  			  (atributo sintomas)
		        (valor calambresPiernas)
		        (factor ?fc&:(> ?fc 0.2)))
=>
	(bind ?f (* ?fc 0.9))
	(assert	(oavc-m	(objeto ?x)
							(atributo diagnostico)
							(valor estenosisArteriaPierna)
							(factor ?f)))
)

; Si ademas de estenosis en la Arteria de la Pierna es paciente de Riesgo
(defrule arterioesclerosis
  (oavc-m	(objeto ?x)
          (atributo condicion)
          (valor pacienteRiesgo)
          (factor ?fpr&:(> ?fpr 0.2)))
  (oavc-m	(objeto ?x)
	  			(atributo diagnostico)
				  (valor estenosisArteriaPierna)
				  (factor ?fe&:(> ?fe 0.2)))
=>
	(bind ?f (* (min ?fe ?fpr) 0.8))
	(assert	(oavc-m	(objeto ?x)
							(atributo diagnostico)
							(valor arterioesclerosis)
							(factor ?f)))
)


;;; Mostramos por consola los diagnosticos realizados a nuestros Pacientes
(defrule diagnosticar-enfermedad
	(declare (salience -1000))         ; Tendra la prioridad mas baja para que se ejecute la
   (oavc-m	(objeto ?x)              ; ultima de todas las reglas
            (atributo diagnostico)
           	(valor ?enfermedad)
          	(factor ?f1))
=>
	 (printout T "El paciente " ?x ":" crlf)                     ; Mostramos por pantalla el diagnostico
   (printout T "Padece la Enfermedad: " ?enfermedad crlf)      ; de nuestro paciente
   (printout T "Con una certeza de ello del: " ?f1 crlf crlf)
)
