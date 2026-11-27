function isPrime(n) {

    if (n < 2 || n !== Math.floor(n)) {
        console.log("False because of <2 or n!=[n]")
        return false
    }

    if (n==2) {
        return true
    }

    for (let i = 2; i < Math.sqrt(n)+1; i++) {
        if (n%i==0) {
            return false
        }
    }

    return true
}

for (let i = 1; i < 30; i++) {
    console.log(`Number ${i} ${isPrime(i) ? "is prime" : "is not prime"}`)
}

console.log(5%3)

module.exports = {
    isPrime,
}