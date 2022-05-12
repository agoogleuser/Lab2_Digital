function BER = ComputeBER(bit_seq,rec_bit_seq)
    N = length(bit_seq);
    E = sum(xor(bit_seq, rec_bit_seq));
    BER = E/N;
end
