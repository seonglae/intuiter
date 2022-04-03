export type State = {
  loading: boolean
}

export const strict = false

export const state = (): State => ({
  loading: false
})

export const mutations = {
  setLoading(state: State, value: boolean): void  {
    /**
     * @summary - set global loading state
     */
    state.loading = value
  }
}
