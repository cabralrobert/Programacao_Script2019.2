BEGIN {nNotas = 0; nota1 = 0; nota2 = 0; nota3 = 0}
{
    if (NR > 1){
        nNotas++
        nota1 = nota1 + $2
        nota2 = nota2 + $3
        nota3 = nota3 + $4
        mediaAluno[$1] = ($2 + $3 + $4) / 3
        if (mediaAluno[$1] >= 7) {
            situacaoAluno[$1] = "Aprovado"
        }else if((mediaAluno[$1] < 7) && (mediaAluno[$1] >= 4)){
            situacaoAluno[$1] = "Final"
        }else{
            situacaoAluno[$1] = "Reprovado"
        }
    }
}
END { 
    printf "Aluno:Situação:Média\n"
    for(i in mediaAluno) printf "%s:%s:%.1f\n", i, situacaoAluno[i], mediaAluno[i]
    printf "Média das Provas: %.1f %.1f %.1f \n", nota1 / (NR - 1), nota2 / (NR - 1), nota3 / (NR - 1)
 }