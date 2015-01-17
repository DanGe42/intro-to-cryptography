TODO
====

This is a TODO list that roughly corresponds to a table of contents

1. Introduction to cryptography ✔
2. Probability Review
  1. Basics
  2. Expectations
  3. Entropy
  4. Jensen's inequality
  5. Statistical distance
  6. Algorithmic distinguisher
2. History and Background ✔
  1. OTP
3. Stream ciphers
  1. Semantic security and computational indistinguishability
  2. Stream ciphers
  3. Security of stream ciphers
  4. Chosen plaintext attack
4. Block ciphers
  2. Pseudorandom functions
  3. Block ciphers
    1. DES
    2. AES
    3. Security
      1. Substitution permutation network
      2. Meet-in-the-middle (2DES and 3DES)
      3. BEAST
      4. CRIME
5. Message Authentication Codes
  1. Chosen ciphertext attack
    1. Padding oracle attack
      1. POODLE
  2. Hash functions
    1. Hash security
    2. Birthday paradox
    3. Merkle-Damgård construction
    4. Collision-resistance in practice
  3. How to use a MAC
    1. Encrypt-and-MAC
    2. MAC-then-encrypt
    3. Encrypt-then-MAC
6. An introduction to number theory
  1. Fundamental Theorem of Arithmetic
  2. Modular arithmetic
  3. Euclidean Algorithm
  4. Ideals
  5. Groups
    1. Definitions
    1. Examples
    3. Theorems
  6. Primality testing
  7. Algorithms
    1. Exponentiation
    2. Efficient computations on modulo primes
    3. Discrete log
      1. Naive
      2. Baby Step Giant Step
      3. Pollard's Rho
7. Diffie-Hellman key exchange
  1. Formulations of the DH problem
  2. Key exchange security
8. More number theory
  1. Rings and fields
  2. Examples
  3. Theorems
    1. Chinese Remainder Theorem
  4. Pohlis-Hellman discrete log algorithm
9. Public key encryption
  1. ElGamal cryptosystem
  2. RSA
    1. Security (or more importantly, Textbook RSA is insecure)
    2. Padded RSA
      1. PKCS #1v1.5
  3. Attacks on public key encryption
10. Digital signatures
  1. Signature forgery
  2. Textbook RSA signatures
  3. DSA
  4. Aside: NSS vulnerability
11. Very theoretical concepts
  1. Impagliazzo's five worlds
  2. One-way function
  3. OWF candidates
  4. Goldreich-Levin Hardcore Predicates
  5. Applications of OWFs
  6. One-way trapdoor function
  7. CPA indistinguishability (alternate)
  8. Constructing an IND-CPA scheme from an OWTDF
  9. The Random Oracle model
  10. Generators
  11. Composite moduli
  12. Jacobi symbol
13. Other cryptosystems
  1. Goldwasser-Micalic cryptosystem
  2. Pallier cryptosystem
14. Factoring
  1. Pollard p-1
  2. Elliptic curve method
  3. Fermat factorization
  4. Quadratic sieve
  5. Index calculus
  6. Number fields (see Wikipedia for number field sieve)
15. Secret sharing
  1. Shamir secret sharing
  2. Commitment schemes
  3. Pederson commitment
16. Zero-knowledge proofs
  1. A brief introduction to complexity
  2. Interactive proofs
  3. Zero-knowledge interactive proofs
17. Special topics: Lattices
18. Special topics: Side channels
