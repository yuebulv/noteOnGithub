
(Vlax-Get (Vlax-Ename->Vla-object (car (entsel))) 'EndPoint)

(cdr (assoc 11 (entget (car (entsel)))))
(vlax-dump-object vla-object)
(vlax-dump-object Vlax-Get)


