#!/bin/ksh

validate_color()
{
    typeset input="$1"
    typeset type="$2"
    
    typeset foreground_default="#FFFFFF"
    typeset background_default="#000000"

    
	if [[ -n "$input" && "$input" == @(#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]) ]]; then
        echo "$input"
    else
    
        if [[ "$type" == "-fg" ]]; then
            echo "$foreground_default"
        elif [[ "$type" == "-bg" ]]; then
            echo "$background_default"
        else
            echo "Error: el color tiene que estar en comillas."
            exit;
        fi
    fi
}

VALID=$(validate_color "$1" "$2")
echo "$VALID"

