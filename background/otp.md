{% extends "base.md" %}

{% block article %}

# One-time pad

The one-time pad (OTP) is an encryption scheme that takes a key that is the
length of the message and XORs (bitwise exclusive-or) it with the message to
produce the ciphertext.

We will introduce some notation that we will be using from here on:

* $$a \in_R A$$: An element $$a$$ picked randomly from the set $$A$$.
* $$\oplus$$: [XOR](http://en.wikipedia.org/wiki/Exclusive_or)

For a quick refresher on some important properties of the bitwise XOR:

* $$a \oplus b = b \oplus a$$
* $$a \oplus (b \oplus c) = (a \oplus b) \oplus c$$
* $$a \oplus a = 0$$
* $$a \oplus 0 = a$$
* $$a \oplus 1 = \neg a$$
* $$a \oplus b \oplus a = a \oplus a \oplus b = b$$

The OTP cryptosystem is defined as thus. Given a binary message of length $$n$$
($$m \in \{0, 1\}^n$$):

* Key generation ($$Gen$$): $$k \in_R \{0, 1\}^n$$
* Encryption ($$Enc$$): $$Enc_k(m) = k \oplus m = c$$
* Decryption ($$Dec$$): $$Dec_k(c) = c \oplus k = m$$

## Security

Is the one-time pad "secure"? For that matter, what does "secure" even mean? It
could have several combination of these meanings:

* No adversary can compute secret key from ciphertext
* No adversary can compute plaintext from ciphertext
* No adversary can determine a character of plaintext
* No adversary can compute any meaningful information
* No adversary can compute an function of plaintext from ciphertext

### Perfect secrecy

To formalize "security", we begin by defining properties that we want our
encryption scheme to have. One property that we want our scheme to have is
"perfect secrecy", which we will define as follows. Say we have a ciphertext
and we decrypt it to some plaintext message. The probability that this
ciphertext decrypts to this specific message is equal to the probability that
it decrypts to something else.

Some notation first:

* $$M$$: [Random variable](http://en.wikipedia.org/wiki/Random_variable)
  representing the space of plaintext messages
* $$C$$: Random variable representing the space of ciphertext messages
* $$Pr[\cdot]$$: The probability of an event

Formally, for every probability distribution over $$\{m\}$$ (the set of all
messages):

$$ \forall m \in \{m\}, \forall c \in \{c\}, \,
Pr[M = m \given C = c] = Pr[M = m]$$

Or equivalently...

$$Pr[C = c \given M = m] = Pr[C = c]$$

If you know your way around probability, you might recognize that this is
statistical independence:

$$ P(A \cap B) = P(A)P(B) \Leftrightarrow P(A \given B) = P(A)
\Leftrightarrow P(B \given A) = P(B)$$

**Lemma**: We also want our encryption scheme to have the property of *perfect
indistinguishability*. This basically means that ciphertext output by our
encryption scheme is indistinguishable from random noise. This follows directly
from our definition of perfect secrecy.

Formally, for every probability distribution over $$\{m\}$$:

$$ \forall m_0, m_1 \in \{m\}, \forall c \in \{c\}, \,
Pr[C = c \given M = m_0] = Pr[C = c \given M = m_1]$$

---

**Proof**: We first prove that perfect secrecy implies perfect
indistinguishability. Take two messages $$m_0$$ and $$m_1$$. Via our perfect
secrecy:

1. $$Pr[C = c \given M = m_0] = P[C = c]$$
2. $$Pr[C = c \given M = m_1] = P[C = c]$$

Therefore, $$Pr[C = c \given M = m_0] = Pr[C = c \given M = m_1]$$.

We now show that perfect indistinguishability implies perfect secrecy. Given
a probability distribution over $$\{m\}$$, and an arbitrary $$m_0$$ and $$c$$:

$$
\begin{align*}
Pr[C = c] &= \sum_m Pr[C = c \given M = m] \cdot Pr[M = m] \\
          &= \sum_m Pr[C = c \given M = m_0] \cdot Pr[M = m] \\
          &= Pr[C = c \given M = m_0] \cdot \sum_m Pr[M = m] \\
          &= Pr[C = c \given M = m_0] \cdot 1 \\
          &= Pr[C = c \given M = m_0]
\end{align*}
$$

$$\square$$

---

## OTP security

OTP is perfectly secret. This might not be immediately obvious (and we are
going to prove it), but some intuition might help. Say that you're given $$c_i$$
(the $$i$$th bit in the ciphertext $$c$$). You know that the corresponding $$k_i$$
could be either 0 or 1 with equal probability. Thus, you have a 50% chance of
guessing the plaintext $$m_i$$ correctly.

Let's extend this intuition to the entire message: you know that roughly 50% of
$$k$$ is 1s and the other 50% is 0s. Thus, this means that roughly 50% of the
plaintext has had its bits flipped and the other 50% of the bits not flipped.
While this initially sounds like you have the advantage, you have to guess
which 50% of the ciphertext bits were actually flipped. Thus, the probability
that you guess all of these bits correctly is $$\frac{1}{2^l}$$, where $$l$$ is the
length of the message.

More formally, here is our proof that OTP is perfectly secret.

---

**Proof**: Given key $$k$$, message $$m$$, ciphertext $$c$$, and length of the
message/ciphertext $$l$$:

$$
\begin{align*}
Pr[C = c \given M = m] &= Pr[M \oplus k = c \given M = m] \\
                       &= Pr[m \oplus k = c] \\
                       &= Pr[k = c \oplus m] \\
                       &= \frac{1}{2^l}
\end{align*}
$$

For any $$m_0$$ and $$m_1$$:

$$Pr[C = c \given M = m_0] = \frac{1}{2^l} = Pr[C = c \given M = m_1]$$

$$\square$$

---

## Conclusion

In the above sections, we have shown that OTP is perfectly secret, which is
probably enough for our definition of perfect security. So, we are done.

...or are we...

As it turns out, OTP is incredibly impractical to use. One problem that must be
solved for a cryptosystem to be useful is key distribution; two parties that
desire to communicate must be able to agree on what key to use. OTP key
distribution is difficult; parties must agree on what keys to use before all
future communications in order to avoid communicating the key, unencrypted, in
the clear.

In addition, the length of the key must be at least the length of the message.
This forces both parties to limit their message lengths to the length of the
key. As a side note...

**Theorem**: $$(Gen, Enc, Dec)$$ be a perfectly secret encryption scheme. This
implies that $$|K| \geq |M|$$, where $$K = \{k\}$$ and $$M = \{m\}$$ (i.e. the
lengths of the keys are at least the lengths of the messages).

<!-- TODO: this might not be correct -->
<!--
**Proof**: We prove this by the contrapositive: if $$|K| < |M|$$, then our
scheme is not perfectly secure.

Fix a uniform distribution over $$M$$.
Let $$M(c) = \{m : m = Dec_k(c) \text{ for some } k \in K\}$$.
If $$|M(c)| \leq |k|$$, then there must exist some $$m' \in M$$ such that
$$m' \notin M(c)$$. Thus, $$Pr[M = m' \given C = c] = 0 \neq Pr[M = m']$$.
$$\square$$
-->

And finally, OTP keys must not be reused to encrypt multiple messages. Doing so
will compromise the security of the messages and the key, as an attacker will
know that a key is correct if it reveals both messages correctly.

{% endblock %}
