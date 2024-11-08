#include <stdio.h>
#include <stdbool.h>  // 用來返回布爾型結果 (true 或 false)
#include <unistd.h>  // 包含 sleep 函式
#include <stdlib.h>

int main()
{
    int i;
    int *nums;
    int arraysize=0;
    printf("please enter an arraysize\n");
    scanf("%d",&arraysize);
    printf("now array size is:%d\n",arraysize);

 // 動態分配陣列的記憶體
    nums = (int*)malloc(arraysize * sizeof(int));  // 使用 malloc 動態分配記憶體

    if (nums == NULL) {
        // 確認記憶體分配是否成功
        printf("Memory allocation failed!\n");
        return 1;  // 返回錯誤代碼
    }
    
    printf("please enter an array\n");
    for(int i=0;i<arraysize;i++){
        scanf("%d",&nums[i]);
        printf("%d\n",nums[i]);
        printf("%d\n",arraysize);
        
    }
    printf("nums is ");
    for(int i=0;i<arraysize;i++){
        printf("%d ",nums[i]);
    }
    printf("\n");
    for(int i=0;i<arraysize;i++){
        for(int j=i+1;j<arraysize;j++){
            int bitwiseOr=nums[i]|nums[j];
            printf("%d\n",bitwiseOr);
            if ((bitwiseOr&0b1)== 0){
                printf("it has trailing zero\n");
                goto cleanup;
            }
            else{
                printf("no trailing zero\n");
    
            }
        }
        
    }
 cleanup:  
     // 釋放動態分配的記憶體
    free(nums);
    return 0;
   
}
