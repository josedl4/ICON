(deftemplate   oav-u
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

(deftemplate   oav-m
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(multislot valor)
)

(deffacts hechos-supuestamente-univaluados

(oav-u (objeto Juan)
		     (atributo edad)
		     (valor 35))
(oav-u (objeto Juan)
		     (atributo edad)
		     (valor 41))
)

(defrule hechos-univaluados
	?ob1 <- (oav-u (objeto   ?n1)
				  (atributo ?a1)
				  (valor    ?v1))
	?ob2 <- (oav-u (objeto   ?n1)
				  (atributo ?a1)
				  (valor    ?v2 & :(neq ?v1 ?v2)))

	=>

	(retract ?ob2)
  (modify ?ob1 (valor ?v2))

)
