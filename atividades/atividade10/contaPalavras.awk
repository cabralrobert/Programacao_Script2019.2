BEGIN { for(i=1; i <= NF; i++) palavras[$i] = 0; qtdPalavras = 0 }
{
    gsub(/["*^&()#@$,\.!?~;]/,"")
    for(i=1; i<=NF; i++) {
         palavras[$i]++
         qtdPalavras++
    }
} 
END { 
    for(k in palavras) printf "%s:\t%d\n" ,k,palavras[k] | "sort -k2 -n -r";
    printf "Total de Palavras analisadas: %d.\n", qtdPalavras
}