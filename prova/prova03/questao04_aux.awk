{ 
    gsub(/sshd\[/,"",$5); 
    gsub(/\]:/,"",$5); 
    
    if ($8 == "opened") {
        openeds[$5] = $3; 
        dayOpeneds[$5] = $2
    }else {
        closeds[$5] = $3;
        dayClosed[$5] = $2
    }
} 
END { 
    for(i in openeds){ 
        printf "%d;%s;%d;%s;%d\n", i, openeds[i], dayOpeneds[i], closeds[i], dayClosed[i];
    } 
}
