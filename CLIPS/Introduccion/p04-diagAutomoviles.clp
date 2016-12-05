;;;; Añadiriamos alguno de los hechos siguientes para encontrarnos
;;;; en uno u otro escenario
;;;;
;;;; (assert (escenario 1))
;;;; (assert (escenario 2))

(defrule R1
	(comportamientoMotor observacion noArranca)
=>
	( assert (potencia estado noConectada))
)

(defrule R2
	(comportamientoMotor observacion noArranca)
=>
	( assert (combustibleEnMotor estado F))
)

(defrule R3
	(comportamientoMotor observacion sePara)
=>
	( assert (combustibleEnMotor estado F))
)

(defrule R4
	(potencia estado noConectada)
	(Fusible observacion fundido)
=>
	( assert (fusible estado fundido))
)

(defrule R5
	(potencia estado noConectada)
	(bateria observacion vacia)
=>
	( assert (bateria estado baja))
)

(defrule R6
	(combustibleEnMotor estado F)
	(depositoCombustible observacion vacio)
=>
	( assert (depositoCombustible estado vacio))
)

(defrule R7
	(fusible estado fundido)
=>
	( assert (solucion causa fusibleFundido))
)

(defrule R8
	(bateria estado baja)
=>
	( assert (solucion causa bateriaBaja))
)

(defrule R9
	(depositoCombustible estado vacio)
=>
	( assert (solucion causa sinCombustible))
)

(defrule Escenario1
	(declare (salience 1000))
	(escenario 1)

=>
	(assert  (comportamientoMotor observacion noArranca))
	(assert (bateria observacion vacia))
)

(defrule Escenario2
	(declare (salience 1000))
	(escenario 2)

=>
	(assert  (comportamientoMotor observacion sePara))
	(assert (depositoCombustible observacion vacio))
)
