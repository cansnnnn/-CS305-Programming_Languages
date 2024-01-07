
(define (twoOperatorCalculator e)
  (cond
    ((null? e) 0)
    ((number? e) e)
    (else
      (cond
        ((eqv? '+ (car e))
          (twoOperatorCalculator (cdr e)))
        ((eqv? '- (car e))
          (twoOperatorCalculator (cons (- (cadr e)) (cddr e))))
        (else
          (+ (car e) (twoOperatorCalculator (cdr e))))
      )
    )
  )
)

;;-------------------

(define (fourOperatorCalculator e)
  (cond
    ((null? e) 0)
    ((number? e) e)
    (else
      (cond
        ((null? (cdr e)) e)
        ((eqv? '/ (cadr e))
         (fourOperatorCalculator (cons (/ (car e) (caddr e)) (cdddr e))))
        ((eqv? '* (cadr e))
         (fourOperatorCalculator (cons (* (car e) (caddr e)) (cdddr e))))
        (else
         (cons (car e) (fourOperatorCalculator (cdr e))))
      )
    )
  )
)

;;-------------------

(define (Nest exp)
  (cond 
    ((pair? exp) (twoOperatorCalculator (fourOperatorCalculator (calculatorNested exp))))
    (else exp)
  )
)

(define (calculatorNested e)(map Nest e))

;;-------------------

(define (checkOperators e)
  (cond 
    ((null? e) #f)
    ((number? e) #f)
    ((and (pair? (car e)) (null? (cdr e))) 
     (checkOperators (car e)))
    ((and (number? (car e)) (null? (cdr e))) 
     #t)
    ((and (pair? (car e)) 
          (or (eqv? '- (cadr e)) 
              (eqv? '+ (cadr e)) 
              (eqv? '/ (cadr e)) 
              (eqv? '* (cadr e))))
     (and (checkOperators (car e)) 
          (checkOperators (cddr e))))
    ((and (number? (car e)) 
          (or (eqv? '- (cadr e)) 
              (eqv? '+ (cadr e)) 
              (eqv? '/ (cadr e)) 
              (eqv? '* (cadr e))))
     (checkOperators (cddr e)))
    (else #f)
  )
)


;;-------------------

(define (calculator e)
  (cond ((checkOperators e)
         (twoOperatorCalculator (fourOperatorCalculator (calculatorNested e))))
        (else #f)
  )
)


