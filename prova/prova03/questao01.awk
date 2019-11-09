{
    x1 = $1
    y1 = $2
    x2 = $3
    y2 = $4

    distancia = sqrt((x2 - x1)^2 + (y2 - y1)^2)

    printf "Distância entre (%d,%d) e (%d,%d) é %f\n", x1, y1, x2, y2, distancia
}

