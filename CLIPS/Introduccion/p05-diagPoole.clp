; Asistente Diagnostico

;	Hechos iniciales

(deffacts hechos-instancia-especifica
	(live outside t)
	(light l1 t) (ok l1 t) (light l2 t) (ok l2 t)
	(conectado w5 outside) (conectado  l1 w0) (conectado  l2 w4)
	(estado s1 down)  (ok s1 t) (estado s2 up)  (ok s2 t) (estado s3 up)  (ok s3 t)
	(ok cb1 t) (ok cb2 t) (conectado p1 w3) (conectado p2 w6)
)


;	Reglas instancia especifica.

(defrule cb1
	(ok cb1 t)
=>
	(assert(conectado w3 w5))
)

(defrule cb2
	(ok cb2 t)
=>
	(assert(conectado w6 w5))
)

(defrule s1-up
	(ok s1 t)
	(estado s1 up)
=>
	(assert(conectado w1 w3))
)

(defrule s1-down
	(ok s3 t)
	(estado s3 up)
=>
	(assert(conectado w2 w3))
)

(defrule s2-up
	(ok s3 t)
	(estado s3 up)
=>
	(assert(conectado w0 w1))
)

(defrule s2-down
	(ok s3 t)
	(estado s3 up)
=>
	(assert(conectado w0 w2))
)

(defrule s3
	(ok s3 t)
	(estado s3 up)
=>
	(assert(conectado w4 w3))
)


;	Reglas generales

(defrule bombillaLuce
	(light ?x  t)
	(live ?x  t)
	(ok ?x  t)
=>
	(assert(lit ?x  t))
)


(defrule propagarConexiones
	(conectado ?x  ?y)
	(live ?y  t)

=>
	(assert(live ?x  t))
)
