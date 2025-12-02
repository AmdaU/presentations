# Function to save complex matrix in the specified format
using Printf

function save_complex_matrix_txt(matrix, filename)
    """
    Save a complex matrix to a text file in the format:
    (real_part+imag_partj), (real_part+imag_partj), ...
    
    Each row is on a new line, values are comma-separated.
    """
    open(filename, "w") do f
        rows, cols = size(matrix)
        for i in 1:rows
            row_str = " "  # Leading space to match format
            for j in 1:cols
                z = matrix[i, j]
                real_part = real(z)
                imag_part = imag(z)
                
                # Format in scientific notation with 18 decimal places
                real_str = @sprintf("%.18e", real_part)
                imag_str = @sprintf("%.18e", abs(imag_part)) # Use absolute value for imag part
                
                # Determine sign
                sign = imag_part >= 0 ? "+" : "-"
                
                # Format the complex number as (real+imagj) or (real-imagj)
                complex_str = "($real_str$sign$(imag_str)j)"
                
                # Add comma separator (except for last element)
                if j < cols
                    complex_str *= ", "
                end
                
                row_str *= complex_str
            end
            println(f, row_str)
        end
    end
end


