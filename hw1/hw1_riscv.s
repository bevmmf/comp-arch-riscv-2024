.data  #static region    
    nums:       .word 1,3,5,7,9  #testdata0
    numsSize:   .word 4            #testdata0
    newline: .string "\n"   
.text  
.globl main 
main:
    #def a0 a1
    la a0, nums           
    lw a1, numsSize        
    #function call
    jal ra, checktrailingzero  

    li a7, 1               
    mv a1, a0              
    ecall                     

     
    li a7, 4                  
    la a0, newline            
    ecall                     

    
    li a7, 10                  
    ecall                     


checktrailingzero:    
                    addi sp,sp,-8 #adjust stack for 2 items
                    sw s1,4(sp)  # save s1 value in case covered by function
                    sw s0,0(sp)  # save s0 value in case covered by function
                    #calling convection:function argument1(a0=&nums[0])
                                        #function argument2(a1=&numSize)
                    add s0,x0,x0 #int bitwise0r=0
                    add a2,x0,x0 #i=0
                    add t0,a0,x0 #save num[0] in t0
                    # Set pointers for nums[i]
                    add a6,a0,x0          # a6 = &nums[i] (nums[i] pointer)
                           
                    loop1:
                        bge a2,a1,loop1_done  #for(int i ; i < numsSize;)
                        addi a3,a2,1 #j=i+1
                        # Set pointers for nums[j]
                        addi a7,a6,4        # a7 = &nums[i+1] (nums[j] pointer)
                        loop2:
                            bge a3,a1,loop2_done #for(int j ; j < numsSize;)
                            
                            lw a4,0(a6) #a4=num[i] pointer
                            lw a5,0(a7) #a5=num[j] pointer
                            
    
                            
                            or s0,a4,a5 #  int bitwiseOr = nums[i] | nums[j];
                            andi s1,s0,1 #def (bitwiseOr & 1)=s1
                                beq s1,x0,findtrailingzero
                                j unfoundtrailingzero 
                            findtrailingzero:
                                li a0,1 # return true
                                ret
                            unfoundtrailingzero:
                            addi a3,a3,1 #j++
                            addi a7,a7,4 #&nums[j]pointnext
                            j loop2
                        loop2_done:
                        addi a2,a2,1 #i++
                        addi a6,a6,4 #&num[i] pointnext
                        j loop1
                    loop1_done:
                    lw s0,0(sp) # return the s0 original value to s0
                    lw s1,4(sp) # return the s1 original value to s1
                    li a0,0 #return false
                    jr ra
                        
