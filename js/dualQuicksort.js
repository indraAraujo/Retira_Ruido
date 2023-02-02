let matrix = [
	[3, 1, 10, 12],
	[5, 9, 6, 30],
	[8, 43, 21, 65],
	[23, 45, 7, 12]
  ];
  
  let mediana;

  function dualPivotQuicksort(arr, left, right) {
    if (left < right) {
        if (arr[left] > arr[right]) {
            [arr[left], arr[right]] = [arr[right], arr[left]];
        }

        let pivot1 = arr[left];
        let pivot2 = arr[right];
        let less = left + 1;
        let great = right - 1;

        for (let k = less; k <= great; k++) {
            if (arr[k] < pivot1) {
                [arr[k], arr[less]] = [arr[less], arr[k]];
                less++;
            } else if (arr[k] >= pivot2) {
                while (k < great && arr[great] > pivot2) {
                    great--;
                }
                [arr[k], arr[great]] = [arr[great], arr[k]];
                great--;

                if (arr[k] < pivot1) {
                    [arr[k], arr[less]] = [arr[less], arr[k]];
                    less++;
                }
            }
        }

        [arr[left], arr[less - 1]] = [arr[less - 1], arr[left]];
        [arr[right], arr[great + 1]] = [arr[great + 1], arr[right]];

        dualPivotQuicksort(arr, left, less - 2);
        dualPivotQuicksort(arr, great + 2, right);

        if (less < great) {
            dualPivotQuicksort(arr, less, great);
        }
    }
    return arr;
}

  function getMediana(arr) {
	let mediana;
	const tamanho = arr.length;
	if (tamanho % 2 == 1) {
	  mediana = arr[((tamanho + 1) / 2) - 1];
	} else {
	  mediana = (arr[(tamanho / 2)] + arr[((tamanho / 2) - 1)]) / 2;
	}
  
	return mediana;
  }
  
  for (let i = 0; i < 4; i++) {
    dualPivotQuicksort(matrix[i],0,matrix[i].length-1)
  };
  let vetor = [].concat(...matrix);
  dualPivotQuicksort(vetor,0,vetor.length-1)
  mediana = getMediana(vetor);


  console.log(matrix);
  console.log(vetor)
  
  console.log(mediana)