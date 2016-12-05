(deftemplate oav-u "Hecho univaluado"
  (slot objeto (type SYMBOL))
  (slot atributo(type SYMBOL))
  (slot valor)
)

(deftemplate oav-m "Hecho multivaluado"
  (slot objeto (type SYMBOL))
  (slot atributo(type SYMBOL))
  (multislot valor)
)

(defrule hechos-univaluados
  (declare (salience 10000))
  ?ob1 <- (oav-u  (objeto   ?n1)
                  (atributo ?a1)
                  (valor    ?v1))
  ?ob2 <- (oav-u  (objeto   ?n1)
                  (atributo ?a1)
                  (valor    ?v2 & :(neq ?v1 ?v2)))
  =>
  (retract ?ob2)
  (modify ?ob1 (valor ?v2)) )

(deffacts marta
  (oav-u  (objeto marta)
          (atributo sexo)
          (valor mujer))

  (oav-u  (objeto marta)
          (atributo edad)
          (valor 12))

  (oav-m  (objeto marta)
          (atributo sintomas)
          (valor fiebre))

  (oav-m  (objeto marta)
          (atributo evidencia)
          (valor rumorDiastolico))

  (oav-u  (objeto marta)
          (atributo presionSistolica)
          (valor 150))

  (oav-u  (objeto marta)
          (atributo presionDiastolica)
          (valor 60)))

(deffacts datos-luis
  (oav-u  (objeto luis)
          (atributo sexo)
          (valor hombre))

  (oav-u  (objeto luis)
          (atributo edad)
          (valor 60))

  (oav-m  (objeto luis)
          (atributo sintomas)
          (valor dolor-abdominal))

  (oav-m  (objeto luis)
          (atributo evidencia)
          (valor rumor-abdominal masaPulsanteAbdomen))

  (oav-u  (objeto luis)
          (atributo presionSistolica)
          (valor 130))

  (oav-u  (objeto luis)
          (atributo presionDiastolica)
          (valor 90)))

(deffacts enfermedades-cardiovasculares
  (oav-u  (objeto aneurismaArteriaAbdominal)
          (atributo afecta)
          (valor vasosSanguineos))

  (oav-u  (objeto estenosisArterial)
          (atributo afecta)
          (valor vasosSanguineos))

  (oav-u  (objeto arterio-esclerosis)
          (atributo afecta)
          (valor vasosSanguineos))

  (oav-u  (objeto regurgitacionAortica)
          (atributo afecta)
          (valor corazon)))

(defrule aneurismaArteriaAbdominal
  (oav-m  (objeto ?x)
          (atributo evidencia)
          (valor $? rumor-abdominal $?))

  (oav-m  (objeto ?x)
          (atributo evidencia)
          (valor $? masaPulsanteAbdomen $?))

  =>

  (assert (oav-m  (objeto ?x)
                  (atributo diagnostico)
                  (valor aneurismaArteriaAbdominal)))
)

(defrule regurgitacionAortica
  (oav-u  (objeto ?x)
          (atributo presionSistolica)
          (valor ?y &:(> ?y 140)))

  (oav-u  (objeto ?x)
          (atributo presionPulso)
          (valor ?z&:(> ?z 50)))

  (or (oav-m  (objeto ?x)
              (atributo evidencia)
              (valor $? rumorSistolico $?))
      (oav-m  (objeto ?x)
              (atributo evidencia)
              (valor $? dilatacionCorazon $?)))

  =>

  (assert (oav-m  (objeto ?x)
                  (atributo diagnostico)
                  (valor regurgitacionAortica)))
)

(defrule presionPulso
  (oav-u  (objeto ?x)
          (atributo presionSistolica)
          (valor ?y))

  (oav-u  (objeto ?x)
          (atributo presionDiastolica)
          (valor ?z))

  =>

  (bind ?pulso (- ?y ?z))
  (assert (oav-u  (objeto ?x)
                  (atributo presionPulso)
                  (valor ?pulso)))
)

(defrule estenosisArteriaPierna
  (oav-m  (objeto ?x)
          (atributo sintomas)
          (valor $? calambresPierna $?))

  =>

  (assert (oav-m  (objeto ?x)
                  (atributo diagnostico)
                  (valor estenosisArteriaPierna)))
)

(defrule arterioesclerosis
  (oav-m  (objeto ?x)
          (atributo diagnostico)
          (valor estenosisArteriaPierna))

  (oav-m  (objeto ?x)
          (atributo condicion)
          (valor pacienteRiesgo))

  =>

  (assert (oav-m  (objeto ?x)
                  (atributo diagnostico)
                  (valor arterioesclerosis)))
)

(defrule pacienteRiesgo
  (or   (oav-u  (objeto ?x)
                (atributo peso)
                (valor obeso))

        (oav-u  (objeto ?x)
                (atributo fuma)
                (valor ?y&:(> ?y 15)))

        (oav-u  (objeto ?x)
                (atributo edad)
                (valor ?y&:(> ?y 60)))
  )

  =>

  (assert (oav-m  (objeto ?x)
                  (atributo condicion)
                  (valor pacienteRiesgo)))
)

(defrule enfCardiovascular1
  (oav-m  (objeto ?x)
          (atributo afecta)
          (valor vasosSanguineos))

  =>

  (assert (oav-m  (objeto ?x)
                  (atributo tipo)
                  (valor cardioVascular)))
)

(defrule enfCardiovascular2
  (oav-m  (objeto ?x)
          (atributo afecta)
          (valor corazon))

  =>

  (assert (oav-m  (objeto ?x)
                  (atributo tipo)
                  (valor cardioVascular)))
)
